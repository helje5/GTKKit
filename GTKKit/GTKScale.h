// $Id: GTKScale.h,v 1.2 1998/08/09 14:34:23 helge Exp $

/*
   GTKScale.h

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

#include <gtk/gtkscale.h>
#include <gtk/gtkhscale.h>
#include <gtk/gtkvscale.h>
#import <GTKKit/GTKRange.h>

@interface GTKScale : GTKRange
{
}

+ (id)horizontalScale;
+ (id)verticalScale;

// properties

- (void)setDigitsAfterComma:(gint8)_value;

- (void)setDrawsValue:(BOOL)_flag;
- (BOOL)drawsValue;

- (void)setMinValue:(double)_value;
- (double)minValue;
- (void)setMaxValue:(double)_value;
- (double)maxValue;

// private

- (GtkScale *)gtkScale;
+ (guint)typeIdentifier;

- (GtkAdjustment *)_adjustmentForScale;

@end

@interface GTKHorizScale : GTKScale
{
}

+ (id)horizontalScale;
- (id)init;

// private

- (GtkHScale *)gtkHScale;
+ (guint)typeIdentifier;

@end

@interface GTKVertScale : GTKScale
{
}

+ (id)verticalScale;
- (id)init;

// private

- (GtkVScale *)gtkVScale;
+ (guint)typeIdentifier;

@end
