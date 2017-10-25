/*
   GTKSpinButton.h

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

// $Id: GTKSpinButton.h,v 1.6 1998/07/14 13:40:31 helge Exp $

#include <gtk/gtkspinbutton.h>
#import <GTKKit/GTKRange.h>

@interface GTKSpinButton : GTKEntry
{
  GtkAdjustment *adjustment;
}

+ (id)spinButton;
+ (id)spinButtonWithRange:(gfloat)_min:(gfloat)_max wraps:(BOOL)_wraps;
+ (id)spinButtonWithClimbRate:(int)_rate andDigitsAfterComma:(guint)_digits;
- (id)initWithClimbRate:(int)_rate andDigitsAfterComma:(guint)_digits;

// properties

- (void)setDigitsAfterComma:(guint)_value;
- (guint)digitsAfterComma;

- (void)setDoesWrap:(BOOL)_flag;
- (BOOL)doesWrap;

- (void)setClimbRate:(gfloat)_value;
- (gfloat)climbRate;

// adjustment

- (void)setMinValue:(gfloat)_value;
- (gfloat)minValue;
- (void)setMaxValue:(gfloat)_value;
- (gfloat)maxValue;
- (void)setValueRange:(gfloat)_min:(gfloat)_max; // shortcut

- (void)setStepSize:(gfloat)_size;
- (gfloat)stepSize;
- (void)setPageSize:(gfloat)_size;
- (gfloat)pageSize;

// private

- (GtkSpinButton *)gtkSpinbutton;
+ (guint)typeIdentifier;

- (GtkAdjustment *)_adjustmentForSpinButton;

@end
