/*
   GTKObject.m

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

// $Id: GTKObject.m,v 1.9 1998/07/13 10:55:32 helge Exp $

#import "GTKKit.h"
#import "GTKObject.h"
#import "GTKUtilities.h"

@implementation GTKObject

NSMapTable *signalToSelector = NULL;

- (void)loadSignalMappings {
  NSLog(@"loading signal mappings for %s", [[self class] name]);
}
- (void)loadSignalMappingsFromTable:(GTKSignalMapEntry *)_map {
  while (YES) {
    if (_map->signalName == NULL)
      break;

    [self mapSignalWithName:_map->signalName toSelector:_map->selector];
    _map++;
  }
}

+ (void)initialize {
  static BOOL isInitialized = NO;
  
  if (!isInitialized) {
    isInitialized = YES;
    [super initialize];

    signalToSelector = NSCreateMapTable(NSIntMapKeyCallBacks,
                                        NSIntMapValueCallBacks,
                                        256);
  }
}

- (id)initWithGtkObject:(GtkObject *)_object {
  if (_object == NULL) {
    NSLog(@"GTKObject(initWithGtkObject): called with NULL widget !");
    [self release];
    return nil;
  }
  
  if ((self = [super init])) {
    gtkObject = _object;
    [self loadSignalMappings];
    [self loadGtkObject];
  }
  return self;
}

- (void)destroyGtkObject {
  if (gtkObject) {
    gtk_object_destroy(gtkObject);
    gtkObject = NULL;
  }
}

- (void)dealloc {
  /*
  NSLog(@"dealloc objc:%@ gtk:<%@[0x%08X]>",
        [self description], (unsigned)self,
        [self gtkTypeName], gtkObject);
  */
  if (gtkObject) {
    gtk_object_remove_data(gtkObject, GTKDataSelf);
    gtk_object_unref(gtkObject);
    [self destroyGtkObject];
  }
  [super dealloc];

}

// gtk object setup

- (void)loadGtkObject {
  gtk_object_ref(gtkObject);
  gtk_object_set_data(gtkObject, GTKDataSelf, self);
}

// signal handling

- (SEL)handlerForEvent:(GTKSignalEvent *)_event {
  return NULL;
}

- (void)handleEvent:(GTKSignalEvent *)_event {
  NSLog(@"%@: received event: %@", self, _event);
}

// description

- (NSString *)description {
  return [NSString stringWithFormat:@"<%s[0x%08X]>",
                     [[self class] name], gtkObject];
}

// ********** private **********

// object/class system

- (GtkObject *)gtkObject {
  return gtkObject;
}

// user data

- (void)_setUserData:(id)_obj {
  gtk_object_set_user_data(gtkObject, (gpointer)_obj);
}
- (id)_userData {
  return (id)gtk_object_get_user_data(gtkObject);
}

// instance data

- (void)_setObject:(id)_obj forKey:(NSString *)_key {
  gtk_object_set_data(gtkObject, [_key cString], (gpointer)_obj);
}
- (id)_objectForKey:(NSString *)_key {
  return (id)gtk_object_get_data(gtkObject, [_key cString]);
}

// signal observation

- (void)addSelfAsObserverForSignal:(NSString *)_signal
  fromGtkObject:(GtkObject *)_obj {
    
  gtk_signal_connect_interp(_obj,
                            (char *)[_signal cString],
                            gtkSignalMarshaller,
                            (char *)[_signal cString],
                            (const void *)NULL, TRUE);
}
- (void)addSelfAsObserverForSignal:(NSString *)_signal {
  [self addSelfAsObserverForSignal:_signal
        fromGtkObject:gtkObject];
}

- (void)observeSignal:(guint)_signal {
  char *signame = gtk_signal_name(_signal);
  SEL  selector = [self selectorForSignal:_signal];

  if (selector) {
    if ([self respondsToSelector:selector]) {
      gint result;
      result = gtk_signal_connect_interp(gtkObject, signame,
                                         gtkSignalMarshaller, signame,
                                         (const void *)NULL, TRUE);
    }
  }
  else {
    gint result;
    result = gtk_signal_connect_interp(gtkObject, signame,
                                       gtkSignalMarshaller, signame,
                                       (const void *)NULL, TRUE);
  }
}
- (void)observeSignalWithName:(NSString *)_name {
  gint sigid = [self gtkSignalLookup:_name];
  if (sigid > 0)
    [self observeSignal:sigid];
  else {
    NSLog(@"WARNING GTKObject(observeSignalWithName): "
          @"did not find signal %@ in %@", _name, self);
  }
}

- (void)observeSignalsWithNames:(NSString *)_firstName, ... {
  NSString *signame;
  va_list  va;
  
  va_start(va, _firstName);
  signame = _firstName;
  while (signame) {
    gint sigid = [self gtkSignalLookup:signame];

    if (sigid > 0)
      [self observeSignal:sigid];
    else {
      NSLog(@"WARNING GTKObject(observeSignalsWithNames): "
            @"did not find signal %@ in %@", signame, self);
    }
    
    signame = va_arg(va, id);
  }
  va_end(va);
}

// signal mapping

- (void)mapSignal:(guint)_signal toSelector:(SEL)_selector {
  NSMapInsert(signalToSelector, (void *)_signal, (void *)_selector);
}
- (void)mapSignalWithName:(NSString *)_signal toSelector:(SEL)_selector {
  gint sigid = [self gtkSignalLookup:_signal];

  if (sigid > 0)
    NSMapInsert(signalToSelector, (void *)sigid, (void *)_selector);
  else {
    NSLog(@"WARNING GTKObject(mapSignalWithName): "
          @"did not find signal %@ in %@", _signal, self);
  }
}
- (SEL)selectorForSignal:(guint)_signal {
  return (SEL)NSMapGet(signalToSelector, (void *)_signal);
}

@end

@implementation GTKObject(GtkTypeSystem)

+ (guint)gtkSuperTypeOfType:(guint)_typeId {
  return gtk_type_parent(_typeId);
}
+ (NSString *)gtkTypeNameOfType:(guint)_typeId {
  return [NSString stringWithCString:gtk_type_name(_typeId)];
}
+ (gpointer)gtkClassOfType:(guint)_typeId {
  return gtk_type_class(_typeId);
}
+ (void)printGtkClassHierachyOfType:(guint)_typeId {
  gtk_type_describe_heritage(_typeId);
}
+ (void)printGtkTypeTreeOfType:(guint)_typeId showInstanceSize:(BOOL)_flag {
  gtk_type_describe_tree(_typeId, _flag ? TRUE : FALSE);
}

+ (guint)typeIdentifier {
  return gtk_object_get_type();
}
- (guint)typeIdentifier {
  return [[self class] typeIdentifier];
}
+ (guint)superTypeIdentifier {
  return gtk_type_parent([self typeIdentifier]);
}
- (guint)superTypeIdentifier {
  return [[self class] typeIdentifier];
}

- (NSString *)gtkTypeName {
  return [NSString stringWithCString:gtk_type_name([self typeIdentifier])];
}
- (gpointer)gtkClass {
  return gtk_type_class([self typeIdentifier]);
}
- (void)printGtkClassHierachy {
  gtk_type_describe_heritage([self typeIdentifier]);
}
- (void)printGtkTypeTree {
  gtk_type_describe_tree([self typeIdentifier], TRUE);
}

- (BOOL)isKindOfGtkType:(guint)_typeId {
  return gtk_type_is_a([self typeIdentifier], _typeId) ? YES : NO;
}

// signals

+ (guint)gtkSignalLookup:(NSString *)_name {
  gint sigid = gtk_signal_lookup([_name cString], [self typeIdentifier]);
  if (sigid > 0)
    return sigid;
  else {
    NSLog(@"WARNING GTKObject(gtkSignalLookup): "
          @"did not find signal %@(%i) in %s(gtk=%s)",
          _name, sigid, [self name], gtk_type_name([self typeIdentifier]));
    return -1;
  }
}
- (guint)gtkSignalLookup:(NSString *)_name {
  return [[self class] gtkSignalLookup:_name];
}

+ (NSString *)gtkSignalName:(guint)_signal {
  gchar *name = gtk_signal_name(_signal);
  return name ? [NSString stringWithCString:name] : nil;
}
- (NSString *)gtkSignalName:(guint)_signal {
  return [[self class] gtkSignalName:_signal];
}

@end
