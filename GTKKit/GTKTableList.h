/*
   GTKTableList.h

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

// $Id: GTKTableList.h,v 1.1 1998/07/09 06:07:42 helge Exp $

#include <gtk/gtkclist.h>
#import <GTKKit/GTKContainer.h>
#import <GTKKit/GTKControl.h>

@class NSString, NSArray;

extern NSString *GTKTableListColumnDidMoveNotification;
extern NSString *GTKTableListColumnDidResizeNotification;
extern NSString *GTKTableListSelectionDidChangeNotification;

@interface GTKTableList : GTKContainer < GTKControl >
{
  id   target;
  SEL  action;
  id   dataSource;
  BOOL showsColumnTitles; // late init
}

+ (id)tableListWithWidth:(int)_columnCount;
+ (id)tableListWithTitles:(NSArray *)_titles;
- (id)initWithWidth:(int)_columnCount;
- (id)initWithTitles:(NSArray *)_titles;

// accessors

- (void)setBorderStyle:(GtkShadowType)_style;
- (GtkShadowType)borderStyle;

- (void)setSelectionMode:(GtkSelectionMode)_mode;
- (GtkSelectionMode)selectionMode;

- (void)setShowsTitles:(BOOL)_flag;
- (BOOL)doesShowTitles;

- (void)setRowHeight:(gint)_height;
- (gint)rowHeight;

- (void)setDataSource:(id)_object;
- (id)dataSource;

// selection

- (void)selectRowAtIndex:(gint)_idx;
- (void)deselectRowAtIndex:(gint)_idx;
- (NSArray *)selectedRows;

- (void)selectAll:(id)_sender;
- (void)deselectAll:(id)_sender;

// columns

- (gint)numberOfColumns;

- (void)setTitle:(NSString *)_title andWidth:(gint)_width ofColumn:(int)_idx;
- (void)setTitle:(NSString *)_title ofColumn:(int)_idx;
- (void)setWidth:(gint)_width ofColumn:(int)_idx;
- (void)setJustification:(GtkJustification)_j ofColumn:(int)_idx;

// rows

- (gint)numberOfRows;

- (void)clear:(id)_sender;
- (BOOL)isRowVisible:(gint)_idx;

// scrolling

- (void)scrollColumnToLeft:(gint)_col;
- (void)scrollColumnToMiddle:(gint)_col;
- (void)scrollRowToTop:(gint)_row;
- (void)scrollRowToMiddle:(gint)_row;

- (void)setHorizontalPolicy:(GtkPolicyType)_policy;
- (GtkPolicyType)horizontalPolicy;
- (void)setVerticalPolicy:(GtkPolicyType)_policy;
- (GtkPolicyType)verticalPolicy;

// loading

- (void)reloadData;

// actions

- (void)reload:(id)_sender;

- (void)showTitles:(id)_sender;
- (void)hideTitles:(id)_sender;
- (void)freeze:(id)_sender;
- (void)thaw:(id)_sender;

// private

- (GtkCList *)gtkCList;
+ (guint)typeIdentifier;

- (gint)rowCenterOffset;
- (GList *)rowList;

- (GtkWidget *)gtkHorizScrollbar;
- (GtkWidget *)gtkVertScrollbar;

- (void)getRowAndColumnAtPoint:(gint)_x:(gint)_y
  row:(gint *)_row
  column:(gint *)_column;

@end

@interface NSObject(GTKTableListDelegate)

- (void)tableListColumnDidMove:(NSNotification *)_notification;
- (void)tableListColumnDidResize:(NSNotification *)_notification;

- (void)tableListSelectionDidChange:(NSNotification *)_notification;

@end
