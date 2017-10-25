/*
   GTKSpinButton.m

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

// $Id: GTKSpinButton.m,v 1.11 1998/08/16 13:59:15 helge Exp $

#import "common.h"
#import "GTKSpinButton.h"

@implementation GTKSpinButton

+ (id)spinButton {
  return AUTORELEASE([[self alloc] init]);
}
+ (id)spinButtonWithRange:(gfloat)_min:(gfloat)_max wraps:(BOOL)_wraps {
  GTKSpinButton *spinner = [[self alloc] init];

  [spinner setDoesWrap:_wraps];
  [spinner setMinValue:_min];
  [spinner setMaxValue:_max];
  [spinner setDoubleValue:_min];

  return AUTORELEASE(spinner);
}

+ (id)spinButtonWithClimbRate:(int)_rate andDigitsAfterComma:(guint)_digits {
  return AUTORELEASE([[self alloc] initWithClimbRate:_rate
                                   andDigitsAfterComma:_digits]);
}

- (id)init {
  return [self initWithClimbRate:0 andDigitsAfterComma:0];
}
- (id)initWithClimbRate:(int)_rate andDigitsAfterComma:(guint)_digits {
  adjustment = [self _adjustmentForSpinButton];
  if (adjustment == NULL) {
    NSLog(@"GTKSpinButton(init): could not get adjustment !");
    [self release];
    return nil;
  }

  return [self initWithGtkObject:
                 (GtkObject *)gtk_spin_button_new(adjustment, _rate, _digits)];
}

- (void)editableWasChanged {
  [self sendAction:action to:target];
}

- (void)runLateInitialization {
  [super runLateInitialization];
  gtk_signal_emit_by_name((GtkObject *)adjustment, "changed");
}

// properties

- (void)setDigitsAfterComma:(guint)_value {
  gtk_spin_button_set_digits((GtkSpinButton *)gtkObject, _value);
}
- (guint)digitsAfterComma {
  return ((GtkSpinButton *)gtkObject)->digits;
}

- (void)setDoesWrap:(BOOL)_flag {
  gtk_spin_button_set_wrap((GtkSpinButton *)gtkObject, _flag);
}
- (BOOL)doesWrap {
  return ((GtkSpinButton *)gtkObject)->wrap;
}

- (void)setClimbRate:(gfloat)_value {
  gtk_spin_button_construct((GtkSpinButton*)gtkObject,
                            adjustment,
                            _value,
                            ((GtkSpinButton *)gtkObject)->digits);
}
- (gfloat)climbRate {
  return ((GtkSpinButton *)gtkObject)->climb_rate;
}

// adjustment accessors

- (void)setMinValue:(gfloat)_value {
  (adjustment)->lower = _value;
  gtk_signal_emit_by_name((GtkObject *)adjustment, "changed");
}
- (gfloat)minValue {
  return (adjustment)->lower;
}

- (void)setMaxValue:(gfloat)_value {
  (adjustment)->upper = _value;
  gtk_signal_emit_by_name((GtkObject *)adjustment, "changed");
}
- (gfloat)maxValue {
  return (adjustment)->upper;
}

- (void)setValueRange:(gfloat)_min:(gfloat)_max {
  [self setMinValue:_min];
  [self setMaxValue:_max];
}

- (void)setStepSize:(gfloat)_size {
  (adjustment)->step_increment = _size;
  gtk_signal_emit_by_name((GtkObject *)adjustment, "changed");
}
- (gfloat)stepSize {
  return (adjustment)->step_increment;
}

- (void)setPageSize:(gfloat)_size {
  (adjustment)->page_size = _size;
  gtk_signal_emit_by_name((GtkObject *)adjustment, "changed");
}
- (gfloat)pageSize {
  return (adjustment)->page_size;
}

// values

- (void)setDoubleValue:(double)_value {
  gtk_spin_button_set_value((GtkSpinButton *)gtkObject, (gfloat)_value);
}
- (double)doubleValue {
  return (double)gtk_spin_button_get_value_as_float((GtkSpinButton *)gtkObject);
}
- (void)setFloatValue:(float)_value {
  [self setDoubleValue:_value];
}
- (float)floatValue {
  return [self doubleValue];
}

- (void)setIntValue:(int)_value {
  [self setDoubleValue:(double)_value];
}
- (int)intValue {
  return (int)[self doubleValue];
}

- (void)setStringValue:(NSString *)_value {
  [self setDoubleValue:[_value doubleValue]];
}
- (NSString *)stringValue {
  NSString *format = nil;
  
  if ([self digitsAfterComma] > 0)
    format = [NSString stringWithFormat:@"%%.%if", [self digitsAfterComma]];
  else
    format = [NSString stringWithFormat:@"%%f", [self digitsAfterComma]];
  return [NSString stringWithFormat:format, [self doubleValue]];
}

// private

- (GtkSpinButton *)gtkSpinbutton {
  return (GtkSpinButton *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_spin_button_get_type();
}

- (GtkAdjustment *)_adjustmentForSpinButton {
  // value, lower, upper, stepIncr, pageIncr, pageSize
  return (GtkAdjustment *)gtk_adjustment_new(0.0,  // value
                                             0.0,  // lower
                                             10.0, // upper
                                             1.0, // step
                                             5.0,  // page step
                                             0.0); // page size
}

@end
