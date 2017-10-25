/*
   GTKRange.m

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

// $Id: GTKRange.m,v 1.4 1998/08/05 19:08:58 helge Exp $

#import "common.h"
#import "GTKRange.h"

const double GTKIncrementResolution     = 1000.0;
const double GTKPageIncrementResolution = 10.0;

@implementation GTKRange

static void adjChanged(GtkWidget *adjustment, gpointer data) {
  [(id)data adjustmentChanged];
}
static void adjValueChanged(GtkWidget *adjustment, gpointer data) {
  [(id)data adjustmentValueChanged];
}

- (id)initWithGtkObject:(GtkObject *)_obj {
  if ((self = [super initWithGtkObject:_obj])) {
    GtkAdjustment *adjustment =
      gtk_range_get_adjustment((GtkRange *)gtkObject);
    
    if (adjustment)
      [self _applySignalsOnAdjustment:adjustment];
  }
  return self;
}

- (void)dealloc {
  [self setTarget:nil];
  [super dealloc];
}

// events

- (void)_applySignalsOnAdjustment:(GtkAdjustment *)_adjustment {
  gtk_signal_connect((GtkObject *)_adjustment,
                     "changed",
                     (GtkSignalFunc)adjChanged,
                     (gpointer)self);
  gtk_signal_connect((GtkObject *)_adjustment,
                     "value_changed",
                     (GtkSignalFunc)adjValueChanged,
                     (gpointer)self);
}

- (void)adjustmentChanged {
  NSLog(@"%@: adjustmentChanged", self);
  [self sendAction:action to:target];
}
- (void)adjustmentValueChanged {
  [self sendAction:action to:target];
}

// accessors

- (void)setContinuous:(BOOL)_flag {
  [self setUpdatePolicy:
          _flag ? GTK_UPDATE_CONTINUOUS : GTK_UPDATE_DISCONTINUOUS];
}
- (BOOL)isContinuous {
  return ([self updatePolicy] == GTK_UPDATE_CONTINUOUS);
}

- (gint8)digitsAfterComma {
  return ((GtkRange *)gtkObject)->digits;
}

// adjustment

- (void)setLower:(gfloat)_value {
  ((GtkRange *)gtkObject)->adjustment->lower = _value;
  gtk_signal_emit_by_name((GtkObject *)((GtkRange *)gtkObject)->adjustment,
                          "changed");
}
- (gfloat)lower {
  return ((GtkRange *)gtkObject)->adjustment->lower;
}
- (void)setUpper:(gfloat)_value {
  ((GtkRange *)gtkObject)->adjustment->upper = _value;
  gtk_signal_emit_by_name((GtkObject *)((GtkRange *)gtkObject)->adjustment,
                          "changed");
}
- (gfloat)upper {
  return ((GtkRange *)gtkObject)->adjustment->upper;
}
- (void)setStepIncrement:(gfloat)_value {
  ((GtkRange *)gtkObject)->adjustment->step_increment = _value;
  gtk_signal_emit_by_name((GtkObject *)((GtkRange *)gtkObject)->adjustment,
                          "changed");
}
- (gfloat)stepIncrement {
  return ((GtkRange *)gtkObject)->adjustment->step_increment;
}
- (void)setPageIncrement:(gfloat)_value {
  ((GtkRange *)gtkObject)->adjustment->page_increment = _value;
  gtk_signal_emit_by_name((GtkObject *)((GtkRange *)gtkObject)->adjustment,
                          "changed");
}
- (gfloat)pageIncrement {
  return ((GtkRange *)gtkObject)->adjustment->page_increment;
}
- (void)setPageSize:(gfloat)_value {
  ((GtkRange *)gtkObject)->adjustment->page_size = _value;
  gtk_signal_emit_by_name((GtkObject *)((GtkRange *)gtkObject)->adjustment,
                          "changed");
}
- (gfloat)pageSize {
  return ((GtkRange *)gtkObject)->adjustment->page_size;
}

// values

- (void)setDoubleValue:(double)_value {
  GtkAdjustment *adjustment =
    gtk_range_get_adjustment((GtkRange *)gtkObject);

  if (_value > adjustment->page_size) _value = adjustment->page_size;
  if (_value < adjustment->lower)     _value = adjustment->lower;
  gtk_adjustment_set_value(adjustment, _value);
}
- (double)doubleValue {
  GtkAdjustment *adjustment =
    gtk_range_get_adjustment((GtkRange *)gtkObject);

  return adjustment ? adjustment->value : 0.0;
}

- (void)setIntValue:(int)_value {
  [self setDoubleValue:_value];
}
- (int)intValue {
  return [self doubleValue];
}
- (void)setFloatValue:(float)_value {
  [self setDoubleValue:_value];
}
- (float)floatValue {
  return [self doubleValue];
}

- (void)setStringValue:(NSString *)_string {
  [self setDoubleValue:[_string doubleValue]];
}
- (NSString *)stringValue {
  return [NSString stringWithFormat:@"%f", [self doubleValue]];
}
- (void)setObjectValue:(id)_object {
  [self setDoubleValue:[_object doubleValue]];
}
- (id)objectValue {
  return [NSNumber numberWithDouble:[self doubleValue]];
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

// private

- (GtkRange *)gtkRange {
  return (GtkRange *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_range_get_type();
}

- (guint32)rangeTimer {
  return ((GtkRange *)gtkObject)->timer;
}

- (GtkAdjustment *)gtkAdjustment {
  return gtk_range_get_adjustment((GtkRange *)gtkObject);
}

- (void)setUpdatePolicy:(GtkUpdateType)_policy {
  gtk_range_set_update_policy((GtkRange *)gtkObject, _policy);
}
- (GtkUpdateType)updatePolicy {
  return ((GtkRange *)gtkObject)->policy;
}

@end
