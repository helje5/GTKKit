/*
   GTKNotebook.h

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

// $Id: GTKNotebook.h,v 1.1 1998/07/09 06:07:33 helge Exp $

#include <gtk/gtknotebook.h>
#import <GTKKit/GTKContainer.h>

/*
  The NoteBook Widget is a collection of 'pages' that overlap each other,
  each page contains different information. This widget has become more common
  lately in GUI programming, and it is a good way to show blocks similar
  information that warrant separation in their display.

  GtkPostionType will be one of the following, and they are pretty self
  explanatory. 
    GTK_POS_LEFT 
    GTK_POS_RIGHT 
    GTK_POS_TOP 
    GTK_POS_BOTTOM

  GTK_POS_TOP is the default.
*/

@class NSMutableArray;

@interface GTKNotebook : GTKContainer
{
  NSMutableArray *labels;
}

+ (id)notebook;
- (id)init;

// properties

- (void)setTabPosition:(GtkPositionType)_pos;
- (GtkPositionType)tabPosition;

- (void)setTabsAreVisible:(BOOL)_flag;
- (BOOL)tabsAreVisible;

- (void)setShowsBorder:(BOOL)_flag;
- (BOOL)doesShowBorder;

// pages

- (void)appendPage:(GTKWidget *)_page  withLabel:(GTKWidget *)_label;
- (void)prependPage:(GTKWidget *)_page withLabel:(GTKWidget *)_label;
- (void)insertPage:(GTKWidget *)_page withLabel:(GTKWidget *)_label
  atIndex:(gint)_idx;

- (void)removePageAtIndex:(gint)_idx;
- (void)removePage:(GTKWidget *)_page;

- (void)showPageAtIndex:(gint)_idx;
- (void)showPage:(GTKWidget *)_page;
- (gint)indexOfCurrentPage;
- (GTKWidget *)currentPage;

- (void)appendPage:(GTKWidget *)_page  withTitle:(NSString *)_title;
- (void)prependPage:(GTKWidget *)_page withTitle:(NSString *)_title;

// actions

- (void)nextPage:sender;
- (void)previousPage:sender;

// private

- (GtkNotebook *)gtkNotebook;
+ (guint)typeIdentifier;

- (BOOL)doesNeedTimer;
- (BOOL)isScrollable;
- (guint32)notebookTimer;
- (gint16)tabBorder;

@end
