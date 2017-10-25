/*
   GTKTable.m

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

// $Id: GTKTable.m,v 1.5 1998/08/09 23:37:55 helge Exp $

#import "GTKKit.h"
#import "GTKTable.h"

@implementation GTKTableLayoutInfo

- (id)initWithCoverage:(int)_l:(int)_t:(int)_r:(int)_b
  options:(gint)_xo:(gint)_yo
  padding:(gint)_xpad:(gint)_ypad {

  if ((self = [super init])) {
    left   = _l;
    top    = _t;
    right  = _r;
    bottom = _b;
    xoptions = _xo;
    yoptions = _yo;
    xpadding = _xpad;
    ypadding = _ypad;
  }
  return self;
}

+ (id)cellFrom:(int)_left:(int)_top to:(int)_right:(int)_bottom {
  return AUTORELEASE([[self alloc]
                            initWithCoverage:_left:_top:_right:_bottom
                            options:(GTK_EXPAND | GTK_FILL):(GTK_EXPAND | GTK_FILL)
                            padding:0:0]);
}

// accessors

- (gint)left {
  return left;
}
- (gint)top {
  return top;
}
- (gint)right {
  return right;
}
- (gint)bottom {
  return bottom;
}
- (gint)xOptions {
  return xoptions;
}
- (gint)yOptions {
  return yoptions;
}
- (gint)xPadding {
  return xpadding;
}
- (gint)yPadding {
  return ypadding;
}

// description

- (NSString *)description {
  return [NSString stringWithFormat:
                     @"<TableLayout: left=%i top=%i right=%i bottom=%i "
                     @"xpad=%i ypad=%i"
                     @">",
                     [self left], [self top], [self right], [self bottom],
                     [self xPadding], [self yPadding]
                   ];
}

@end

@implementation GTKTable

+ (id)tableWithSize:(int)_rows:(int)_cols {
  return AUTORELEASE([[self alloc]
                            initWithSize:_rows:_cols
                            isHomogeneous:NO]);
}
+ (id)tableWithSize:(int)_rows:(int)_cols sameSize:(BOOL)_flag {
  return AUTORELEASE([[self alloc]
                            initWithSize:_rows:_cols
                            isHomogeneous:_flag]);
}

- (id)init {
  return [self initWithSize:0:0 isHomogeneous:NO];
}
- initWithSize:(int)_rows:(int)_cols isHomogeneous:(BOOL)_flag {
  return [self initWithGtkObject:(GtkObject *)gtk_table_new(_rows, _cols, _flag)];
}

// attaching

- (void)addSubWidget:(GTKWidget *)_widget {
  GTKTableLayoutInfo *info = [_widget layout];

  NSAssert([info isKindOfClass:[GTKTableLayoutInfo class]],
           @"invalid widget layout for container");
  
  gtk_table_attach((GtkTable *)gtkObject, [_widget gtkWidget],
                   [info left], [info right], [info top], [info bottom],
                   [info xOptions], [info yOptions],
                   [info xPadding], [info yPadding]);
  [self _primaryAddSubWidget:_widget];
}

// accessors

- (void)setSpacing:(gint)_spacing ofRow:(gint)_row {
  NSAssert(gtkObject, @"invalid gtk object reference");
  gtk_table_set_row_spacing((GtkTable *)gtkObject, _row, _spacing);
}
- (void)setSpacing:(gint)_spacing ofColumn:(gint)_column {
  NSAssert(gtkObject, @"invalid gtk object reference");
  gtk_table_set_col_spacing((GtkTable *)gtkObject, _column, _spacing);
}
- (void)setRowSpacings:(int)_spacing {
  NSAssert(gtkObject, @"invalid gtk object reference");
  gtk_table_set_row_spacings((GtkTable *)gtkObject, _spacing);
}
- (void)setColumnSpacings:(int)_spacing {
  NSAssert(gtkObject, @"invalid gtk object reference");
  gtk_table_set_col_spacings((GtkTable *)gtkObject, _spacing);
}

- (void)setRowCount:(guint16)_rowCount {
  NSAssert(gtkObject, @"invalid gtk object reference");
  gtk_table_resize((GtkTable *)gtkObject, _rowCount, [self columnCount]);
}
- (guint16)rowCount {
  NSAssert(gtkObject, @"invalid gtk object reference");
  return ((GtkTable *)gtkObject)->nrows;
}

- (void)setColumnCount:(guint16)_columnCount {
  NSAssert(gtkObject, @"invalid gtk object reference");
  gtk_table_resize((GtkTable *)gtkObject, [self rowCount], _columnCount);
}
- (guint16)columnCount {
  NSAssert(gtkObject, @"invalid gtk object reference");
  return ((GtkTable *)gtkObject)->ncols;
}

- (guint16)columnSpacing {
  NSAssert(gtkObject, @"invalid gtk object reference");
  return ((GtkTable *)gtkObject)->column_spacing;
}
- (guint16)rowSpacing {
  NSAssert(gtkObject, @"invalid gtk object reference");
  return ((GtkTable *)gtkObject)->row_spacing;
}

- (void)setIsHomogeneous:(BOOL)_flag {
  NSAssert(gtkObject, @"invalid gtk object reference");
  gtk_table_set_homogeneous((GtkTable *)gtkObject, _flag);
}
- (BOOL)isHomogeneous {
  NSAssert(gtkObject, @"invalid gtk object reference");
  return ((GtkTable *)gtkObject)->homogeneous;
}

// private

- (GtkTable *)gtkTable {
  return (GtkTable *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_table_get_type();
}

- (GtkTableRowCol)rowAtIndex:(int)_idx {
  return ((GtkTable *)gtkObject)->rows[_idx];
}
- (GtkTableRowCol)columnAtIndex:(int)_idx {
  return ((GtkTable *)gtkObject)->cols[_idx];
}

@end
