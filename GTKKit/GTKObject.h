/*
   GTKObject.h

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

// $Id: GTKObject.h,v 1.7 1998/07/11 22:15:36 helge Exp $

#include <gtk/gtksignal.h>
#include <gtk/gtkobject.h>
#import <Foundation/NSObject.h>
#import <GTKKit/GTKUtilities.h>

@class NSNotification;
@class GTKSignalEvent;

typedef struct {
  NSString *signalName;
  SEL      selector;
} GTKSignalMapEntry;

@interface GTKObject : NSObject
{
  GtkObject *gtkObject;
}

- (id)initWithGtkObject:(GtkObject *)_object;
- (void)dealloc;

// gtk object setup

- (void)loadGtkObject; // call this after allocating a gtk object
- (void)loadSignalMappings;
- (void)loadSignalMappingsFromTable:(GTKSignalMapEntry *)_map;

// signal handling

- (SEL)handlerForEvent:(GTKSignalEvent *)_event;
- (void)handleEvent:(GTKSignalEvent *)_event;

// private

- (GtkObject *)gtkObject;

- (void)_setUserData:(id)_obj;
- (id)_userData;
- (void)_setObject:(id)_obj forKey:(NSString *)_key;
- (id)_objectForKey:(NSString *)_key;

// observing

- (void)addSelfAsObserverForSignal:(NSString *)_signal
  fromGtkObject:(GtkObject *)_obj;
- (void)addSelfAsObserverForSignal:(NSString *)_signal;

// these methods check whether the signal is mapped and
// whether the object responds to the mapped selector
- (void)observeSignal:(guint)_signal;
- (void)observeSignalWithName:(NSString *)_name;
- (void)observeSignalsWithNames:(NSString *)_firstName, ...;

// signal mapping

- (void)mapSignal:(guint)_signal toSelector:(SEL)_selector;
- (void)mapSignalWithName:(NSString *)_signal toSelector:(SEL)_selector;
- (SEL)selectorForSignal:(guint)_signal;

@end

@interface GTKObject(GtkTypeSystem)

// to make this work, the subclass has to override -typeIdentifier

+ (guint)gtkSuperTypeOfType:(guint)_typeId;
+ (NSString *)gtkTypeNameOfType:(guint)_typeId;
+ (gpointer)gtkClassOfType:(guint)_typeId;
+ (void)printGtkClassHierachyOfType:(guint)_typeId;
+ (void)printGtkTypeTreeOfType:(guint)_typeId showInstanceSize:(BOOL)_flag;

+ (guint)typeIdentifier;       // id of gtk class
- (guint)typeIdentifier;       // id of gtk class
+ (guint)superTypeIdentifier;  // id of gtk super class
- (guint)superTypeIdentifier;  // id of gtk super class

- (NSString *)gtkTypeName;     // name of gtk class
- (gpointer)gtkClass;          // pointer to gtk class structure
- (void)printGtkClassHierachy; // prints out the class hierachy
- (void)printGtkTypeTree;      // prints the type tree
- (BOOL)isKindOfGtkType:(guint)_typeId;

// signals

+ (guint)gtkSignalLookup:(NSString *)_name;
- (guint)gtkSignalLookup:(NSString *)_name;
+ (NSString *)gtkSignalName:(guint)_signal;
- (NSString *)gtkSignalName:(guint)_signal;

@end
