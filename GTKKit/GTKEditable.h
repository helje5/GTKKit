/*
   GTKEditable.h

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

// $Id: GTKEditable.h,v 1.2 1998/08/05 13:33:45 helge Exp $

#include <gtk/gtkeditable.h>
#import <GTKKit/GTKWidget.h>
#import <GTKKit/GTKControl.h>

#include <Foundation/NSGeometry.h> // jet

@class NSString, NSDate;

@interface GTKEditable : GTKWidget < GTKControl >
{
  id  target;
  SEL action;
}

// events

- (void)editableWasChanged;
- (void)editableWasActivated;

// position

- (guint)point;

// edit state

- (BOOL)isEditable;

// selection

- (void)setSelectedRange:(NSRange)_range;
- (NSRange)selectedRange;
- (BOOL)hasSelection;
- (void)deleteSelection;

// operations

- (void)insertString:(NSString *)_value atIndex:(gint *)_pos;
- (void)deleteInRange:(NSRange)_range;

// clipboard

- (void)cut;
- (void)copy;
- (void)paste;
- (void)claimAtDate:(NSDate *)_date doClaim:(BOOL)_flag;

// values

- (void)setStringValue:(NSString *)_string; // abstract
- (NSString *)stringValue;                  // abstract

- (void)setObjectValue:(id)_object;
- (id)objectValue;

- (void)setIntValue:(int)_value;
- (int)intValue;
- (void)setFloatValue:(float)_value;
- (float)floatValue;
- (void)setDoubleValue:(double)_value;
- (double)doubleValue;

// private

- (GtkEditable *)gtkEditable;
+ (guint)typeIdentifier;

@end
