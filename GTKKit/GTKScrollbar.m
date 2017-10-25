// $Id: GTKScrollbar.m,v 1.2 1998/08/09 14:38:00 helge Exp $

/*
   GTKScrollbar.m

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

#import "GTKKit.h"
#import "GTKScrollbar.h"

@implementation GTKScrollbar

+ (id)horizontalScrollbar {
  return [GTKHorizScrollbar horizontalScrollbar];
}
+ (id)verticalScrollbar {
  return [GTKVertScrollbar verticalScrollbar];
}

// accessors

- (void)setPageCount:(int)_value {
  [self setUpper:(double)_value * [self pageSize]];
  NSLog(@"adjustment: %@",
        [GTKAdjustment descriptionOfGtkAdjustment:[self gtkAdjustment]]);
}
- (double)pageCount {
  return ([self upper] - 1.0) / [self pageSize];
}

- (void)setPageSize:(double)_value {
  [super setPageSize:_value];
  [super setPageIncrement:_value];

  NSLog(@"adjustment: %@",
        [GTKAdjustment descriptionOfGtkAdjustment:[self gtkAdjustment]]);
}

// private

- (GtkScrollbar *)gtkScrollbar {
  return (GtkScrollbar *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_scrollbar_get_type();
}

- (GtkAdjustment *)_adjustmentForScrollbar {
  // value, lower, upper, stepIncr, pageIncr, pageSize
  return (GtkAdjustment *)gtk_adjustment_new(0.0,  // value
                                             0.0,  // lower
                                             101.0,  // upper
                                             0.01, // step
                                             1.0,  // page step
                                             1.0); // page size
}

@end

@implementation GTKHorizScrollbar

+ (id)horizontalScrollbar {
  return AUTORELEASE([[self alloc] init]);
}
- (id)init {
  GtkAdjustment *adjustment;

  adjustment = [self _adjustmentForScrollbar];
  if (adjustment == NULL) return nil;
  return [self initWithGtkObject:(GtkObject *)gtk_hscrollbar_new(adjustment)];
}

// private

- (GtkHScrollbar *)gtkHScrollbar {
  return (GtkHScrollbar *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_hscrollbar_get_type();
}

@end

@implementation GTKVertScrollbar

+ (id)verticalScrollbar {
  return AUTORELEASE([[self alloc] init]);
}
- (id)init {
  GtkAdjustment *adjustment;

  adjustment = [self _adjustmentForScrollbar];
  if (adjustment == NULL) return nil;

  return [self initWithGtkObject:(GtkObject *)gtk_vscrollbar_new(adjustment)];
}

// private

- (GtkVScrollbar *)gtkVScrollbar {
  return (GtkVScrollbar *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_vscrollbar_get_type();
}

@end
