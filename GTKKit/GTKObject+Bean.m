// $Id: GTKObject+Bean.m,v 1.2 1998/08/16 20:34:25 helge Exp $

#include <ctype.h>
#include <objc/objc-api.h>
#import "common.h"
#import "GTKObject+Bean.h"

@implementation GTKObject(Bean)

- (id)initWithPropertyList:(id)_propertyList {
  NSAssert([_propertyList isKindOfClass:[NSDictionary class]],
           @"invalid property list argument (must be an dictionary)");
  
  if ((self = [self init]))
    [self takeValuesFromDictionary:_propertyList];
  return self;
}

- (BOOL)takeValue:(id)_value forKey:(NSString *)_key {
  int  len = [_key cStringLength];
  char setMethodName[len + 6];
  SEL  setSelector;
  
  NSAssert(len > 0, @"ABORT: invalid property name");
  setMethodName[0] = 's';
  setMethodName[1] = 'e';
  setMethodName[2] = 't';
  setMethodName[3] = '\0';
  strcat(setMethodName, [_key cString]);
  setMethodName[3] = toupper(setMethodName[3]);
  setMethodName[len + 3] = ':';
  setMethodName[len + 4] = '\0';

  setSelector = sel_get_any_uid(setMethodName);
  if (setSelector) {
    if ([self respondsToSelector:setSelector]) {
      NSMethodSignature *signature  = nil;
      NSInvocation      *invocation = nil;

      signature  = [self methodSignatureForSelector:setSelector];
      invocation = [NSInvocation invocationWithMethodSignature:signature];

      [invocation setTarget:self];
      [invocation setSelector:setSelector];

      if (invocation) {
        union {
          id            object;
          SEL           selector;
          unsigned char character;
          short         sht;
          int           integer;
          long          lng;
          float         flt;
          double        dbl;
          unsigned char *cstr;
        } argument;
        const char *argType = NULL;
#if LIB_FOUNDATION_LIBRARY
        argType = [signature argumentInfoAtIndex:2].type;
#else
        argType = [signature getArgumentAtIndex:2];
#endif

        switch (*argType) {
          case _C_ID:
          case _C_CLASS:
            argument.object = _value;
            break;

          case _C_CHARPTR:
            if ([_value isKindOfClass:[NSString class]])
              argument.cstr = (char *)[_value cString];
            else
              argument.cstr = (char *)[[_value stringValue] cString];
            break;

          case _C_SEL:
            if (![_value isKindOfClass:[NSString class]])
              _value = [_value stringValue];
            if (_value)
              argument.selector = sel_get_uid([_value cString]);
            else
              argument.selector = NULL;

            //NSLog(@"made selector %@ from %@",
            //      NSStringFromSelector(argument.selector), _value);
            break;

          case _C_SHT:  argument.sht     = [_value shortValue];         break;
          case _C_USHT: argument.sht     = [_value unsignedShortValue]; break;
          case _C_INT:  argument.integer = [_value intValue];           break;
          case _C_UINT: argument.integer = [_value unsignedIntValue];   break;
          case _C_LNG:  argument.lng     = [_value longValue];          break;
          case _C_ULNG: argument.lng     = [_value unsignedLongValue];  break;
            
          case _C_CHR:
          case _C_UCHR:
            argument.character = [_value charValue];
            break;
          case _C_FLT:
            argument.flt = [_value floatValue];
            break;
          case _C_DBL:
            argument.dbl = [_value doubleValue];
            break;
          
          default:
            NSLog(@"WARNING: unsupported base type '%s' of property %@",
                  argType, _key);
            return NO;
        }

        [invocation setArgument:&argument atIndex:2];

        // run invocation
        [invocation invoke];

        return YES;
      }
    }
  }
  return NO;
}

- (void)takeValuesFromDictionary:(NSDictionary *)_dictionary {
  NSEnumerator *keys = [_dictionary keyEnumerator];
  NSString     *key  = nil;

  while ((key = [keys nextObject])) {
    id value = [_dictionary objectForKey:key];
    
    if (![self takeValue:value forKey:key]) {
      NSLog(@"ERROR(%s): could not set value %@ for property '%@'",
            __PRETTY_FUNCTION__, value, key);
    }
  }
}

@end

void __link_GTKObject_Bean(void) {
  ;
  [GTKObject class];
  __link_GTKObject_Bean();
}
