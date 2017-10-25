/*
   GTKTable.h

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

// $Id: GTKTable.h,v 1.4 1998/08/09 23:37:55 helge Exp $

#include <gtk/gtktable.h>
#import <GTKKit/GTKContainer.h>

/*
  The rows and columnts are laid out starting with 0 to n, where n was the
  number specified in the call to tableWithSize:. So, if you specify rows = 2
  and columns = 2, the layout would look something like this: 

       0          1          2
      0+----------+----------+
       |          |          |
      1+----------+----------+
       |          |          |
      2+----------+----------+

  The left and right arguments specify where to place the widget, and how many
  boxes to use. If you want a button in the lower right table entry of our 2x2
  table, and want it to fill that entry ONLY, it would be
  
    [table addSubWidget:myWidget fromPoint:1:1 toPoint:2:2]
    
  Now, if you wanted a widget to take up the whole top row of our 2x2 table,
  you'd use
  
    [table addSubWidget:myWidget fromPoint:0:0 toPoint:2:1]
    
  The options are used to specify packing options and may be OR'ed together:
  
    GTK_FILL   - If the table box is larger than the widget, and GTK_FILL is
                 specified, the widget will expand to use all the room available. 
    GTK_SHRINK - If the table widget was allocated less space then was requested
                 (usually by the user resizing the window), then the widgets
                 would normally just be pushed off the bottom of the window and
                 disappear. If GTK_SHRINK is specified, the widgets will shrink
                 with the table. 
    GTK_EXPAND - This will cause the table to expand to use up any remaining
                 space in the window.

  Padding is just like in boxes, creating a clear area around the widget
  specified in pixels.
*/

@interface GTKTableLayoutInfo : GTKLayoutInfo
{
  gint left;
  gint top;
  gint right;
  gint bottom;
  gint xoptions; // default: GTK_EXPAND | GTK_FILL
  gint yoptions; // default: GTK_EXPAND | GTK_FILL
  gint xpadding; // default: 0
  gint ypadding; // default: 0
}

+ (id)cellFrom:(int)_left:(int)_top to:(int)_right:(int)_bottom;

- (gint)left;
- (gint)top;
- (gint)right;
- (gint)bottom;
- (gint)xOptions;
- (gint)yOptions;
- (gint)xPadding;
- (gint)yPadding;

@end

@interface GTKTable : GTKContainer
{
}

+ (id)tableWithSize:(int)_rows:(int)_cols sameSize:(BOOL)_flag;
- (id)initWithSize:(int)_rows:(int)_cols isHomogeneous:(BOOL)_flag;

// ********** attaching **********

- (void)addSubWidget:(GTKWidget *)_widget;

// ********** accessors **********

- (void)setSpacing:(gint)_spacing ofRow:(gint)_row;
- (void)setSpacing:(gint)_spacing ofColumn:(gint)_column;
- (void)setRowSpacings:(int)_spacing;
- (void)setColumnSpacings:(int)_spacing;

- (guint16)columnSpacing;
- (guint16)rowSpacing;

- (void)setRowCount:(guint16)_rowCount;
- (guint16)rowCount;
- (void)setColumnCount:(guint16)_columnCount;
- (guint16)columnCount;

- (void)setIsHomogeneous:(BOOL)_flag;
- (BOOL)isHomogeneous;

// private

- (GtkTable *)gtkTable;
+ (guint)typeIdentifier;

@end
