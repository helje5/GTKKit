// $Id: GTKRange.h,v 1.1 1998/07/09 06:07:37 helge Exp $

/*
   GTKRange.h

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

#include <gtk/gtkrange.h>
#import <GTKKit/GTKWidget.h>
#import <GTKKit/GTKControl.h>

@interface GTKRange : GTKWidget < GTKControl >
{
  id  target;
  SEL action;
}

// events

- (void)adjustmentChanged;
- (void)adjustmentValueChanged;

// accessors

- (gint8)digitsAfterComma;

- (void)setContinuous:(BOOL)_flag;
- (BOOL)isContinuous;

// adjustment

- (void)setLower:(gfloat)_value;
- (gfloat)lower;
- (void)setUpper:(gfloat)_value;
- (gfloat)upper;
- (void)setStepIncrement:(gfloat)_value;
- (gfloat)stepIncrement;
- (void)setPageIncrement:(gfloat)_value;
- (gfloat)pageIncrement;
- (void)setPageSize:(gfloat)_value;
- (gfloat)pageSize;

// values

- (void)setDoubleValue:(double)_value;
- (double)doubleValue;

- (void)setIntValue:(int)_value;
- (int)intValue;
- (void)setFloatValue:(float)_value;
- (float)floatValue;

- (void)setStringValue:(NSString *)_string;
- (NSString *)stringValue;
- (void)setObjectValue:(id)_object;
- (id)objectValue;

// private

- (GtkRange *)gtkRange;
+ (guint)typeIdentifier;

- (guint32)rangeTimer;
- (GtkAdjustment *)gtkAdjustment;
- (void)_applySignalsOnAdjustment:(GtkAdjustment *)_adjustment;

- (void)setUpdatePolicy:(GtkUpdateType)_policy;
- (GtkUpdateType)updatePolicy;

@end
