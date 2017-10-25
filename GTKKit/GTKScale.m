/*
   GTKScale.m

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

// $Id: GTKScale.m,v 1.2 1998/08/09 14:34:24 helge Exp $

#import "GTKKit.h"
#import "GTKScale.h"

@implementation GTKScale

+ (id)horizontalScale {
  return [GTKHorizScale horizontalScale];
}
+ (id)verticalScale {
  return [GTKVertScale verticalScale];
}

// properties

- (void)setDigitsAfterComma:(gint8)_value {
  gtk_scale_set_digits((GtkScale *)gtkObject, _value);
}

- (void)setDrawsValue:(BOOL)_flag {
  gtk_scale_set_draw_value((GtkScale *)gtkObject, _flag ? TRUE : FALSE);
}
- (BOOL)drawsValue {
  return ((GtkScale *)gtkObject)->draw_value;
}

- (void)setMinValue:(double)_value {
  double maxValue = [self maxValue];
  
  [self setLower:_value];
  [self setStepIncrement:(maxValue - _value)];
  [self setPageIncrement:(maxValue - _value)];

  NSLog(@"adjustment: %@",
        [GTKAdjustment descriptionOfGtkAdjustment:[self gtkAdjustment]]);
}
- (double)minValue {
  return [self lower];
}

- (void)setMaxValue:(double)_value {
  double minValue = [self minValue];
  
  [self setUpper:_value + 1.0];
  [self setStepIncrement:(_value - minValue)];
  [self setPageIncrement:(_value - minValue)];
  [self setPageSize:_value];

  NSLog(@"adjustment: %@",
        [GTKAdjustment descriptionOfGtkAdjustment:[self gtkAdjustment]]);
}
- (double)maxValue {
  return [self gtkAdjustment]->page_size;
}

// private

- (GtkScale *)gtkScale {
  return (GtkScale *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_scale_get_type();
}

- (GtkAdjustment *)_adjustmentForScale {
  // value, lower, upper, stepIncr, pageIncr, pageSize
  return (GtkAdjustment *)gtk_adjustment_new(0.0,  // value
                                             0.0,  // lower
                                             2.0,  // upper
                                             0.01, // step
                                             0.1,  // page step
                                             1.0); // page size
}

@end

@implementation GTKHorizScale

+ (id)horizontalScale {
  return AUTORELEASE([[self alloc] init]);
}
- (id)init {
  GtkAdjustment *adjustment;

  adjustment = [self _adjustmentForScale];
  if (adjustment == NULL) return nil;

  return [self initWithGtkObject:(GtkObject *)gtk_hscale_new(adjustment)];
}

// private

- (GtkHScale *)gtkHScale {
  return (GtkHScale *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_hscale_get_type();
}

@end


@implementation GTKVertScale

+ (id)verticalScale {
  return AUTORELEASE([[self alloc] init]);
}
- (id)init {
  GtkAdjustment *adjustment;

  adjustment = [self _adjustmentForScale];
  if (adjustment == NULL) return nil;

  return [self initWithGtkObject:(GtkObject *)gtk_vscale_new(adjustment)];
}

// private

- (GtkVScale *)gtkVScale {
  return (GtkVScale *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_vscale_get_type();
}

@end
