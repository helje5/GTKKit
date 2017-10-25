/*
   GTKList.m

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

// $Id: GTKList.m,v 1.7 1998/08/05 19:08:57 helge Exp $

#import "common.h"
#import "GTKList.h"
#import "GTKScrolledWindow.h"

@implementation GTKList

+ (id)list {
  return [[[self alloc] init] autorelease];
}
- (id)init {
  return [self initWithGtkObject:(GtkObject *)gtk_list_new()];
}

- (void)dealloc {
  [target release]; target = nil;
  [super dealloc];
}

// init widget

- (void)loadGtkObject {
  [super loadGtkObject];
  [self addSelfAsObserverForSignal:@"selection_changed"];
}

// signals

- (void)selectionDidChange {
  [self sendAction:action to:target];
}

- (void)handleEvent:(GTKSignalEvent *)_event {
  if ([[_event signalName] isEqualToString:@"selection_changed"])
    [self selectionDidChange];
  else
    [super handleEvent:_event];
}

// control

- (void)setTarget:(id)_target {
  ASSIGN(target, _target);
}
- (id)target {
  return target;
}

- (void)setAction:(SEL)_action {
  action = _action;
}
- (SEL)action {
  return action;
}

- (BOOL)sendAction:(SEL)_action to:(id)_target {
  return [GTKApp sendAction:_action to:_target from:self];
}

// accessors

- (void)setSelectionMode:(GtkSelectionMode)_mode {
  gtk_list_set_selection_mode((GtkList *)gtkObject, _mode);
}
- (GtkSelectionMode)selectionMode {
  return ((GtkList *)gtkObject)->selection_mode;
}

// modifying

// selection

- (void)selectItemAtIndex:(gint)_idx {
  gtk_list_select_item((GtkList *)gtkObject, _idx);
}
- (void)deselectItemAtIndex:(gint)_idx {
  gtk_list_unselect_item((GtkList *)gtkObject, _idx);
}

- (NSArray *)selectedItems {
  GtkSelectionMode mode = ((GtkList *)gtkObject)->selection_mode;
  GList *selection = ((GtkList *)gtkObject)->selection;

  if (selection == NULL)
    return [NSArray array];
  else if ((mode == GTK_SELECTION_SINGLE) || (mode == GTK_SELECTION_BROWSE))
    return [NSArray arrayWithObject:GTKGetObject(selection->data)];
  else if (mode == GTK_SELECTION_EXTENDED)
    return nil;
  else {
    NSMutableArray *array = nil;
    int selCount = 0;
    
    while (selection) {
      selCount++;
      selection = selection->next;
    }

    array = [NSMutableArray arrayWithCapacity:selCount + 1];
    selection = ((GtkList *)gtkObject)->selection;

    while (selection) {
      [array addObject:GTKGetObject(selection->data)];
      selection = selection->next;
    }

    return array;
  }
}

// private

- (GtkList *)gtkList {
  return (GtkList *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_list_get_type();
}

#if GTKKIT_GTK_11
- (guint)hTimer {
  return ((GtkList *)gtkObject)->htimer;
}
- (guint)vTimer {
  return ((GtkList *)gtkObject)->vtimer;
}
#else
- (guint32)listTimer {
  return ((GtkList *)gtkObject)->timer;
}
#endif

- (GList *)children {
  return ((GtkList *)gtkObject)->children;
}

#if !(GTKKIT_GTK_11)
- (guint16)selectionStartIndex {
  return ((GtkList *)gtkObject)->selection_start_pos;
}
- (guint16)selectionEndIndex {
  return ((GtkList *)gtkObject)->selection_end_pos;
}
#endif

- (GList *)selection {
  return ((GtkList *)gtkObject)->selection;
}

@end
