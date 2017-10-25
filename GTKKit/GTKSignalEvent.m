// $Id: GTKSignalEvent.m,v 1.3 1998/07/11 19:10:06 helge Exp $

#import "common.h"
#import "GTKSignalEvent.h"
#import "GTKWidget.h"
#import "GTKUtilities.h"

@implementation GTKSignalEvent

- (void)_resolveArguments:(GtkArg *)_args count:(guint)_argc {
  if (_argc > 0) {
    int cnt;
    
    args = [[NSMutableDictionary alloc] initWithCapacity:(_argc + 1)];

    for (cnt = 0; cnt < _argc; cnt++) {
      GtkArg   *argument = &(_args[cnt]);
      NSString *argName  = nil;
      id       value     = nil;

      if (argument->name != NULL)
        argName = [NSString stringWithCString:argument->name];
      else
        argName = [NSString stringWithFormat:@"%i", cnt];

      value = gtkObjectifyArgument(argument);

      if (value)
        [args setObject:value forKey:argName];
      else {
        NSLog(@"marshaller: could not objectify signal argument %@ (event=%@)",
              argName, self);
      }
      
      argName = nil;
      value   = nil;
    }

    if ([args count] == 0) {
      RELEASE(args);
      args = nil;
    }
  }
}

+ (id)eventWithSignalName:(NSString *)_name receiver:(GTKObject *)_obj
  arguments:(GtkArg *)_args count:(guint)_argc {
  return AUTORELEASE([[self alloc] initWithName:_name receiver:_obj
                                   arguments:_args count:_argc]);
}

- (id)initWithName:(NSString *)_name receiver:(GTKObject *)_obj
  arguments:(GtkArg *)_args count:(guint)_argc {
  if ((self = [super init])) {
    signalName = RETAIN(_name);
    receiver   = RETAIN(_obj);

    [self _resolveArguments:_args count:_argc];
  }
  return self;
}

- (void)dealloc {
  RELEASE(receiver);   receiver   = nil;
  RELEASE(signalName); signalName = nil;
  RELEASE(args);       args       = nil;
  [super dealloc];
}

// accessors

- (NSString *)signalName {
  return signalName;
}
- (gint)signal {
  if (signal == 0)
    signal = [receiver gtkSignalLookup:signalName];
  return signal;
}

- (GTKObject *)receiver {
  return receiver;
}

- (id)valueOfArgument:(NSString *)_name {
  return [args objectForKey:_name];
}

// description

- (NSString *)argDescription {
  if ([args count] > 0) {
    NSMutableString *str = [[NSMutableString alloc] init];
    NSEnumerator *keys = [args keyEnumerator];
    NSString     *name = nil;
    BOOL         isFirst = YES;

    while ((name = [keys nextObject])) {
      if (isFirst) isFirst = NO;
      else [str appendString:@", "];

      [str appendString:name];
      [str appendString:@"="];
      [str appendString:[[self valueOfArgument:name] description]];
    }

    return AUTORELEASE(str);
  }
  else {
    return @"<no args>";
  }
}

- (NSString *)description {
  return [NSString stringWithFormat:@"<Signal name=%@ receiver=%@<0x%08X> args=%@>",
                     [self signalName],
                     [[self receiver] class], (unsigned)[self receiver],
                     [self argDescription]];
}

@end
