/*
   GKModule.m

   Copyright (C) 1998 Helge Hess.
   All rights reserved.

   Author: Helge Hess <helge@mdlink.de>

   This file is part of GTKKit.

   Permission to use, copy, modify, and distribute this software and its
   documentation for any purpose and without fee is hereby granted, provided
   that the above copyright notice appear in all copies and that both that
   copyright notice and this permission notice appear in supporting
   documentation.

   We disclaim all warranties with regard to this software, including all
   implied warranties of merchantability and fitness, in no event shall
   we be liable for any special, indirect or consequential damages or any
   damages whatsoever resulting from loss of use, data or profits, whether in
   an action of contract, negligence or other tortious action, arising out of
   or in connection with the use or performance of this software.
*/

// $Id: GKModule.m,v 1.19 1998/08/16 19:49:13 helge Exp $

#include <ctype.h>
#include <objc/objc-api.h>
#import "common.h"
#import "GKModule.h"
#import "GKModuleParser.h"
#import "GKMAttribute.h"

@interface NSObject(PropertListInit)
- (id)initWithPropertyList:(id)_propList;
@end

@implementation GKModule

+ (GKModule *)moduleFromPath:(NSString *)_path owner:(id)_owner {
  GKModuleParser *parser = nil;
  GKModule       *module = [[GKModule alloc] init];

  [module registerObject:_owner withName:@"OWNER"];

  parser = [[GKModuleParser alloc] init];
  [parser parseModule:module fromPath:_path];
  RELEASE(parser); parser = nil;

  return AUTORELEASE(module);
}

- (id)init {
  if ((self = [super init])) {
    nameToObject = [[NSMutableDictionary alloc] initWithCapacity:512];
    objectZone   = [self zone];
  }
  return self;
}

#if !LIB_FOUNDATION_BOEHM_GC
- (void)dealloc {
  RELEASE(nameToObject); nameToObject = nil;
  [super dealloc];
}
#endif

// name service

- (void)registerObject:(id)_object {
  NSString *name = [NSString stringWithFormat:@"0x%08X", (unsigned)_object];

  [self registerObject:_object withName:name];
}

- (void)registerObject:(id)_object withName:(NSString *)_name {
  id obj;
  
  if ((obj = [nameToObject objectForKey:_name]))
    NSLog(@"WARNING: there already was a object registered for name '%@'", _name);

  if (_object == nil) {
    NSLog(@"ERROR: tried to register object '%@' without reference ..", _name);
    return;
  }
  
  [nameToObject setObject:_object forKey:_name];
}

- (id)objectForName:(NSString *)_name {
  id obj = [nameToObject objectForKey:_name];

  if (obj == nil)
    NSLog(@"WARNING: did not found object for name %@", _name);
  
  return obj;
}

- (NSEnumerator *)allNamedObjectsOfClass:(Class)_class {
  NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:16];
  NSEnumerator   *objEnum = [nameToObject objectEnumerator];
  id             object;

  while ((object = [objEnum nextObject])) {
    if ([object isKindOfClass:_class])
      [result addObject:object];
  }
  object = RETAIN([result objectEnumerator]);
  RELEASE(result);
  return AUTORELEASE(object);
}

// factory

- (id)produceObjectForName:(NSString *)_tagName attributes:(NSDictionary *)_attrs {
  Class c = NSClassFromString(_tagName);
  
  if (c) {
    id obj = [c allocWithZone:objectZone];

    if (obj == nil) {
      NSLog(@"WARNING(%s): could not allocate object of class '%s'",
            __PRETTY_FUNCTION__, [c name]);
      return nil;
    }

    //NSLog(@"producing object of class %@ with attributes %@", _tagName, _attrs);

    if ([c instancesRespondToSelector:@selector(initWithPropertyList:)]) {
      obj = [obj initWithPropertyList:_attrs];
    }
    else {
      NSEnumerator *keys          = [_attrs keyEnumerator];
      NSString     *attributeName = nil;

      obj = [obj init];

      while ((attributeName = [keys nextObject])) {
        NSInvocation *setInvocation = nil;
        id           attributeValue = [_attrs objectForKey:attributeName];

        //NSLog(@"setting property '%@' to '%@' in object 0x%08X<%s>",
        //      attributeName, attributeValue, (unsigned)obj, [c name]);

        setInvocation = [self invocationToSetValue:attributeValue
                              forProperty:attributeName
                              ofObject:obj];
        if (setInvocation)
          [setInvocation invoke];
        else {
          NSLog(@"ERROR(%s): could not set value for "
                @"property %@ of object 0x%08X<%s>",
                __PRETTY_FUNCTION__, attributeName, (unsigned)obj, [c name]);
        }
      }
    }

    return AUTORELEASE(obj);
  }
  else {
    NSLog(@"ERROR(%s): did not find class for tag name '%@'",
          __PRETTY_FUNCTION__, _tagName);
    return nil;
  }
}

- (id)produceFixedLayoutWithValues:(NSDictionary *)_values {
  int x = [[_values objectForKey:@"x"] intValue];
  int y = [[_values objectForKey:@"y"] intValue];

  return [GTKFixedLayoutInfo layoutAtPoint:x:y];
}
- (id)produceBoxLayoutWithValues:(NSDictionary *)_values {
  int  padding = 0;
  BOOL expand  = YES;
  BOOL fill    = YES;
  id   value   = nil;

  if ((value = [_values objectForKey:@"expand"])) {
    value = [[value stringValue] lowercaseString];
    if ([value isEqualToString:@"no"] || [value isEqualToString:@"0"])
      expand = NO;
  }
  if ((value = [_values objectForKey:@"fill"])) {
    value = [[value stringValue] lowercaseString];
    if ([value isEqualToString:@"no"] || [value isEqualToString:@"0"])
      fill = NO;
  }
  if ((value = [_values objectForKey:@"padding"])) {
    padding = [value intValue];
  }

  return [GTKBoxLayoutInfo layoutWithPadding:padding doExpand:expand doFill:fill];
}
- (id)produceTableLayoutWithValues:(NSDictionary *)_values {
  if ([_values objectForKey:@"x"]) { // just a cell
    int x, y;
    x = [[_values objectForKey:@"x"] intValue];
    y = [[_values objectForKey:@"y"] intValue];

    return [GTKTableLayoutInfo cellAt:x:y];
  }
  else { // complete description
    int le, te, re, be;

    le = [[_values objectForKey:@"left"]   intValue];
    te = [[_values objectForKey:@"top"]    intValue];
    re = [[_values objectForKey:@"right"]  intValue];
    be = [[_values objectForKey:@"bottom"] intValue];

    return [GTKTableLayoutInfo cellFrom:le:te to:re:be];
  }
}

- (NSInvocation *)invocationToSetValue:(id)_value
  forProperty:(NSString *)_property ofObject:(id)_object {

  int  len = [_property cStringLength];
  char setMethodName[len + 6];
  SEL  setSelector;

  NSAssert(len > 0, @"ABORT: invalid property name");
  
  setMethodName[0] = 's';
  setMethodName[1] = 'e';
  setMethodName[2] = 't';
  setMethodName[3] = '\0';
  strcat(setMethodName, [_property cString]);
  setMethodName[3] = toupper(setMethodName[3]);
  setMethodName[len + 3] = ':';
  setMethodName[len + 4] = '\0';

  setSelector = sel_get_any_uid(setMethodName);
  if (setSelector) {
    if ([_object respondsToSelector:setSelector]) {
      NSMethodSignature *signature  = nil;
      NSInvocation      *invocation = nil;

      signature  = [_object methodSignatureForSelector:setSelector];
      invocation = [NSInvocation invocationWithMethodSignature:signature];

      [invocation setTarget:_object];
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
                  argType, _property);
            return nil;
        }

        [invocation setArgument:&argument atIndex:2];
        [invocation retainArguments];

        return AUTORELEASE(RETAIN(invocation));
      }
    }
  }
  else {
    NSLog(@"ERROR: did not find selector for name '%s'", setMethodName);
  }
  return nil;
}

- (void)addSubWidget:(GTKWidget *)_widget toContainer:(GTKContainer *)_container {
  if ([_container isKindOfClass:[GTKSingleContainer class]]) {
    //NSLog(@"adding to single container %@%@ ..", _container, [_container class]);
    [(GTKSingleContainer *)_container setContentWidget:_widget];
  }
  else {
    //NSLog(@"adding to container %@%@ ..", _container, [_container class]);
    [_container addSubWidget:_widget];
  }
}

// description

- (NSString *)description {
  return [NSString stringWithFormat:@"<Module: registry=%@>", nameToObject];
}

@end
