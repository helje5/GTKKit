/*
   GTKAdjustment.m

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

// $Id: GTKAdjustment.m,v 1.4 1998/07/13 10:55:29 helge Exp $

#import "common.h"
#import "GTKAdjustment.h"

@implementation GTKAdjustment

+ adjustment:(gfloat)_lower:(gfloat)_upper
  value:(gfloat)_value
  stepIncrement:(gfloat)_stepIncr
  pageIncrement:(gfloat)_pageIncr
  pageSize:(gfloat)_page {

  return [[[self alloc]
                 initWithAdjustment:_lower:_upper
                 value:_value
                 stepIncrement:_stepIncr
                 pageIncrement:_pageIncr
                 pageSize:_page]
                 autorelease];
}

- initWithAdjustment:(gfloat)_lower:(gfloat)_upper
  value:(gfloat)_value
  stepIncrement:(gfloat)_stepIncr
  pageIncrement:(gfloat)_pageIncr
  pageSize:(gfloat)_page {

  GtkObject *obj;
  obj = gtk_adjustment_new(_value,
                           _lower, _upper,
                           _stepIncr, _pageIncr,
                           _page);
  return [self initWithGtkObject:obj];
}

- (void)loadGtkObject {
  [super loadGtkObject];
  [self observeSignalsWithNames:@"changed", @"value_changed", nil];
}

// properties

- (void)setValue:(gfloat)_value {
  gtk_adjustment_set_value((GtkAdjustment *)gtkObject, _value);
}
- (gfloat)value {
  return ((GtkAdjustment *)gtkObject)->value;
}

- (void)setLower:(gfloat)_value {
  ((GtkAdjustment *)gtkObject)->lower = _value;
  gtk_signal_emit_by_name(gtkObject, "changed");
}
- (gfloat)lower {
  return ((GtkAdjustment *)gtkObject)->lower;
}
- (void)setUpper:(gfloat)_value {
  ((GtkAdjustment *)gtkObject)->upper = _value;
  gtk_signal_emit_by_name(gtkObject, "changed");
}
- (gfloat)upper {
  return ((GtkAdjustment *)gtkObject)->upper;
}
- (void)setStepIncrement:(gfloat)_value {
  ((GtkAdjustment *)gtkObject)->step_increment = _value;
  gtk_signal_emit_by_name(gtkObject, "changed");
}
- (gfloat)stepIncrement {
  return ((GtkAdjustment *)gtkObject)->step_increment;
}
- (void)setPageIncrement:(gfloat)_value {
  ((GtkAdjustment *)gtkObject)->page_increment = _value;
  gtk_signal_emit_by_name(gtkObject, "changed");
}
- (gfloat)pageIncrement {
  return ((GtkAdjustment *)gtkObject)->page_increment;
}
- (void)setPageSize:(gfloat)_value {
  ((GtkAdjustment *)gtkObject)->page_size = _value;
  gtk_signal_emit_by_name(gtkObject, "changed");
}
- (gfloat)pageSize {
  return ((GtkAdjustment *)gtkObject)->page_size;
}

// private

- (GtkAdjustment *)gtkAdjustment {
  return (GtkAdjustment *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_adjustment_get_type();
}

// description

+ (NSString *)descriptionOfGtkAdjustment:(GtkAdjustment *)_adj {
  return [NSString stringWithFormat:
                     @"<lower=%.2f upper=%.2f value=%.2f "
                     @"step=%.2f page=%.2f size=%.2f>",
                     _adj->lower, _adj->upper, _adj->value,
                     _adj->step_increment,
                     _adj->page_increment,
                     _adj->page_size];
}

- (NSString *)description {
  return [NSString stringWithFormat:
                     @"<%s[0x%08X] lower=%f upper=%f value=%f "
                     @"step++=%f page++=%f size=%f>",
                     [[self class] name], (unsigned)self,
                     [self lower], [self upper], [self value],
                     [self stepIncrement],
                     [self pageIncrement],
                     [self pageSize]];
}

@end
