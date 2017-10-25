/*
   GTKContainer.m

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

// $Id: GTKContainer.m,v 1.9 1998/08/05 13:42:01 helge Exp $

#import "GTKKit.h"
#import "GTKContainer.h"

@implementation GTKContainer

- (void)dealloc {
  [subWidgets release]; subWidgets = nil;
  [super dealloc];
}

// init

static GTKSignalMapEntry sigs[] = {
  { @"add",          @selector(containerWidgetAdded:) },
  { @"remove",       @selector(containerWidgetRemoved:) },
  { NULL, NULL }
};

- (void)loadSignalMappings {
  static BOOL loadedMappings = NO;

  if (!loadedMappings) {
    loadedMappings = YES;
    [super loadSignalMappings];
    [self loadSignalMappingsFromTable:sigs];
  }
}

- (void)loadGtkObject {
  [super loadGtkObject];
  [self observeSignalsWithNames:@"add", @"remove", nil];
}

// hierachy management

- (NSMutableArray *)_allocateSubWidgetStorage {
  return [[NSMutableArray alloc] initWithCapacity:16];
}

- (void)_primaryAddSubWidget:(GTKWidget *)_widget {
  if (subWidgets == nil) subWidgets = [self _allocateSubWidgetStorage];
  [subWidgets addObject:_widget];
  [_widget setSuperWidget:self];
}
- (void)_primaryRemoveSubWidget:(GTKWidget *)_widget {
  [_widget setSuperWidget:nil];
  [subWidgets removeObject:_widget];
}
- (void)_primaryInsertSubWidget:(GTKWidget *)_widget atIndex:(int)_idx {
  if (subWidgets == nil) subWidgets = [self _allocateSubWidgetStorage];
  [subWidgets insertObject:_widget atIndex:_idx];
  [_widget setSuperWidget:self];
}

- (void)addSubWidget:(GTKWidget *)_widget {
  NSAssert(gtkObject != NULL, @"gtk widget is null");
  NSAssert(_widget, @"sub widget is nil");
  
  gtk_container_add(GTK_CONTAINER(gtkObject), [_widget gtkWidget]);
  [self _primaryAddSubWidget:_widget];
}

- (void)removeSubWidget:(GTKWidget *)_widget {
  NSAssert(gtkObject != NULL, @"gtk widget is null");
  NSAssert(_widget, @"sub widget is nil");
  
  [self _primaryRemoveSubWidget:_widget];
  gtk_container_remove(GTK_CONTAINER(gtkObject), [_widget gtkWidget]);
}

- (void)addSubWidgets:(GTKWidget *)_first,... {
  va_list va;
  
  va_start(va, _first);
  [self addSubWidgets:_first arguments:va];
  va_end(va);
}
- (void)addSubWidgets:(GTKWidget *)_first arguments:(va_list)_other {
  id sw = _first;

  do {
    [self addSubWidget:sw];
    sw = va_arg(_other, id);
  }
  while (sw != nil);
}

- (NSArray *)subWidgets {
  return subWidgets;
}

// showing

- (void)showAll {
  [subWidgets makeObjectsPerform:@selector(showAll)];
  [self show];
}
- (void)hideAll {
  [self hide];
  [subWidgets makeObjectsPerform:@selector(hideAll)];
}

// properties

- (void)setBorderWidth:(gint)_width {
  gtk_container_border_width((GtkContainer *)gtkObject, _width);
}
- (gint)borderWidth {
  return ((GtkContainer *)gtkObject)->border_width;
}

#if !(GTKKIT_GTK_11)
- (void)setResizingEnabled:(BOOL)_flag {
  if (_flag)
    gtk_container_enable_resize((GtkContainer *)gtkObject);
  else
    gtk_container_disable_resize((GtkContainer *)gtkObject);
}
- (BOOL)isResizingEnabled {
  return (((GtkContainer *)gtkObject)->auto_resize == 1) ? YES : NO;
}
#endif

#if GTKKIT_GTK_11

- (void)setResizeMode:(GtkResizeMode)_mode {
  gtk_container_set_resize_mode((GtkContainer *)gtkObject, _mode);
}
- (void)checkResize {
  gtk_container_check_resize((GtkContainer *)gtkObject);
}

#else

- (void)blockResizing {
  gtk_container_block_resize((GtkContainer *)gtkObject);
}
- (void)unblockResizing {
  gtk_container_unblock_resize((GtkContainer *)gtkObject);
}

#endif

// private

- (GtkContainer *)gtkContainer {
  return (GtkContainer *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_container_get_type();
}

// description

- (NSString *)description {
  return [NSString stringWithFormat:@"<%s[0x%08X] %@ border=%i>",
                     [[self class] name], gtkObject,
                     [self frameDescription],
                     [self borderWidth]
                   ];
}

@end
