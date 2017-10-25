/*
   GTKAdjustment.h

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

// $Id: GTKAdjustment.h,v 1.1 1998/07/09 06:07:13 helge Exp $

#include <gtk/gtkadjustment.h>
#import <GTKKit/GTKData.h>

@interface GTKAdjustment : GTKData
{
}

+ adjustment:(gfloat)_lower:(gfloat)_upper
  value:(gfloat)_value
  stepIncrement:(gfloat)_stepIncr
  pageIncrement:(gfloat)_pageIncr
  pageSize:(gfloat)_page;

- initWithAdjustment:(gfloat)_lower:(gfloat)_upper
  value:(gfloat)_value
  stepIncrement:(gfloat)_stepIncr
  pageIncrement:(gfloat)_pageIncr
  pageSize:(gfloat)_page;

// properties

- (void)setValue:(gfloat)_value;
- (gfloat)value;

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

// private

- (GtkAdjustment *)gtkAdjustment;
+ (guint)typeIdentifier;

// description

+ (NSString *)descriptionOfGtkAdjustment:(GtkAdjustment *)_adj;

@end
