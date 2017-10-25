/*
   GTKText.h

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

// $Id: GTKText.h,v 1.1 1998/07/09 06:07:43 helge Exp $

#include <gtk/gtktext.h>
#import <GTKKit/GTKEditable.h>

@class NSMutableString;
@class GTKAdjustment;

@interface GTKText : GTKEditable
{
  NSMutableString *lateContent;
}

+ (id)text;
+ (id)textWithAdjustment:(GTKAdjustment *)_horiz:(GTKAdjustment *)_vert;
- (id)initWithAdjustment:(GTKAdjustment *)_horiz:(GTKAdjustment *)_vert;

// running late initialization

- (void)runLateInitialization;
- (void)storeLateAttributes;

// text properties

- (guint)textCapacity;
- (guint)gapPosition;
- (guint)gapSize;

- (guint)indexOfLastCharacter;     // The last character position.
- (guint)indexOfFirstVisibleLine;  // Index to the start of the first visible line.
- (guint)pixelsCutOfTopLine;       // The number of pixels cut off of the top line.
- (guint)firstHorizontalPixel;     // First visible horizontal pixel.
- (guint)firstVerticalPixel;       // First visible vertical pixel.

- (gint)horizontalCursorPosition;  // Position of cursor.
- (gint)verticalCursorPosition;    // Baseline of line cursor is drawn on.
- (gint)virtualHorizontalPosition; // Where it would be if it could be.

// tabulators

- (NSArray *)tabulatorStops;
- (gint)defaultTabulatorWidth;

// properties

- (void)setEditable:(BOOL)_flag;

- (BOOL)hasCursor;
- (BOOL)isLineWrappingEnabled;

// selection

- (void)selectAll:(id)sender;

// adjustments

- (void)setAdjustments:(GTKAdjustment *)_horiz:(GTKAdjustment *)_vert;
- (GTKAdjustment *)horizontalAdjustment;
- (GTKAdjustment *)verticalAdjustment;

// operations

- (void)freeze;
- (void)thaw;

// point

- (void)setPoint:(guint)_idx;
- (guint)point;
- (void)movePointToStart;
- (void)movePointToEnd;
- (guint)textLength;

// modifying

- (gint)deleteLeft:(guint)_numChars;
- (gint)deleteRight:(guint)_numChars;
- (void)deleteAll;
- (void)insertStringAtPoint:(NSString *)_value;
- (void)setPoint:(guint)_idx andInsertString:(NSString *)_value;
- (void)appendString:(NSString *)_value;

- (void)setString:(NSString *)_value; // OpenStep (calls setStringValue:)

// values

- (void)setStringValue:(NSString *)_value;
- (NSString *)stringValue;

// private

- (GtkText *)gtkText;
+ (guint)typeIdentifier;

@end
