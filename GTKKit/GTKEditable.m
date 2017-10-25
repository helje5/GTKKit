/*
   GTKEditable.m

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

// $Id: GTKEditable.m,v 1.7 1998/08/05 19:08:56 helge Exp $

#import "common.h"
#import "GTKEditable.h"
#import "GTKWindow.h"

@implementation GTKEditable

- (void)dealloc {
  RELEASE(target); target = nil;
  [super dealloc];
}

// init gtk

- (void)loadGtkObject {
  [super loadGtkObject];
  [self observeSignalsWithNames:@"activate", @"changed", nil];
}

// signals

- (void)editableWasChanged {
  // NSLog(@"%@: was changed", self);
}

- (void)editableWasActivated {
  //  NSLog(@"%@: was activated", self);

  if (![self sendAction:action to:target]) {
    if (![[self window] performKeyEquivalent:nil]) {
      // [self selectText:self];
      ;
    }
  }
  
}

- (void)handleEvent:(GTKSignalEvent *)_event {
  if ([[_event signalName] isEqualToString:@"changed"])
    [self editableWasChanged];
  else if ([[_event signalName] isEqualToString:@"activate"])
    [self editableWasActivated];
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

// position

- (guint)point {
  return ((GtkEditable *)gtkObject)->current_pos;
}

// edit state

- (BOOL)isEditable {
  return ((GtkEditable *)gtkObject)->editable;
}

// selection

- (void)setSelectedRange:(NSRange)_range {
  gtk_editable_select_region((GtkEditable *)gtkObject,
                             _range.location,
                             _range.location + _range.length);
}
- (NSRange)selectedRange {
  NSRange range;
  range.location = ((GtkEditable *)gtkObject)->selection_start_pos;
  range.length   = ((GtkEditable *)gtkObject)->selection_end_pos -
                   ((GtkEditable *)gtkObject)->selection_start_pos;
  return range;
}

- (BOOL)hasSelection {
  return ((GtkEditable *)gtkObject)->has_selection;
}

- (void)deleteSelection {
  gtk_editable_delete_selection((GtkEditable *)gtkObject);
}

// operations

- (void)insertString:(NSString *)_value atIndex:(gint *)_pos {
  gtk_editable_insert_text((GtkEditable *)gtkObject,
                           [_value cString],
                           [_value cStringLength],
                           _pos);
}

- (void)deleteInRange:(NSRange)_range {
  gtk_editable_delete_text((GtkEditable *)gtkObject,
                           _range.location,
                           _range.location + _range.length);
}

// clipboard

- (void)cut {
#if GTKKIT_GTK_11
  gtk_editable_cut_clipboard((GtkEditable *)gtkObject);
#else
  gtk_editable_cut_clipboard((GtkEditable *)gtkObject, time(NULL));
#endif
}
- (void)copy {
#if GTKKIT_GTK_11
  gtk_editable_copy_clipboard((GtkEditable *)gtkObject);
#else
  gtk_editable_copy_clipboard((GtkEditable *)gtkObject, time(NULL));
#endif
}
- (void)paste {
#if GTKKIT_GTK_11
  gtk_editable_paste_clipboard((GtkEditable *)gtkObject);
#else
  gtk_editable_paste_clipboard((GtkEditable *)gtkObject, time(NULL));
#endif
}

- (void)claimAtDate:(NSDate *)_date doClaim:(BOOL)_flag {
  gtk_editable_claim_selection((GtkEditable *)gtkObject, _flag,
                               [_date timeIntervalSince1970]);
}

// values

- (void)setStringValue:(NSString *)_value {
  [self subclassResponsibility:_cmd];
}

- (NSString *)stringValue {
  [self subclassResponsibility:_cmd];
  return nil;
}

- (void)setObjectValue:(id)_object {
  [self setStringValue:[_object stringValue]];
}
- (id)objectValue {
  return [self stringValue];
}

- (void)setIntValue:(int)_value {
  [self setStringValue:[NSString stringWithFormat:@"%i", _value]];
}
- (int)intValue {
  return [[self stringValue] intValue];
}
- (void)setFloatValue:(float)_value {
  [self setStringValue:[NSString stringWithFormat:@"%f", _value]];
}
- (float)floatValue {
  return [[self stringValue] floatValue];
}
- (void)setDoubleValue:(double)_value {
  [self setStringValue:[NSString stringWithFormat:@"%f", _value]];
}
- (double)doubleValue {
  return [[self stringValue] doubleValue];
}

// private

- (GtkEditable *)gtkEditable {
  return (GtkEditable *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_editable_get_type();
}

@end
