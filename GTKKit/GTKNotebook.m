/*
   GTKNotebook.m

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

// $Id: GTKNotebook.m,v 1.4 1998/08/16 14:01:07 helge Exp $

#import "common.h"
#import "GTKNotebook.h"
#import "GTKLabel.h"

@implementation GTKNotebook

+ (id)notebook {
  return [[[self alloc] init] autorelease];
}
- (id)init {
  return [self initWithGtkObject:(GtkObject *)gtk_notebook_new()];
}

- (void)dealloc {
  [labels release]; labels = nil;
  [super dealloc];
}

// properties

- (void)setTabPosition:(GtkPositionType)_pos {
  gtk_notebook_set_tab_pos((GtkNotebook *)gtkObject, _pos);
}
- (GtkPositionType)tabPosition {
  return ((GtkNotebook *)gtkObject)->show_tabs;
}

- (void)setTabsAreVisible:(BOOL)_flag {
  gtk_notebook_set_show_tabs((GtkNotebook *)gtkObject, _flag ? TRUE : FALSE);
}
- (BOOL)tabsAreVisible {
  return ((GtkNotebook *)gtkObject)->show_tabs;
}

- (void)setShowsBorder:(BOOL)_flag {
  gtk_notebook_set_show_border((GtkNotebook *)gtkObject, _flag ? TRUE : FALSE);
}
- (BOOL)doesShowBorder {
  return ((GtkNotebook *)gtkObject)->show_border;
}

// add pages

- (void)appendPage:(GTKWidget *)_page withLabel:(GTKWidget *)_label {
  gtk_notebook_append_page((GtkNotebook *)gtkObject,
                           [_page  gtkWidget],
                           [_label gtkWidget]);
  
  [self _primaryAddSubWidget:_page];
  if (labels == nil) labels = [[NSMutableArray alloc] initWithCapacity:8];
  [labels addObject:_label];
}
- (void)prependPage:(GTKWidget *)_page withLabel:(GTKWidget *)_label {
  gtk_notebook_prepend_page((GtkNotebook *)gtkObject,
                            [_page  gtkWidget],
                            [_label gtkWidget]);
  [self _primaryInsertSubWidget:_page atIndex:0];
  if (labels == nil) labels = [[NSMutableArray alloc] initWithCapacity:8];
  [labels insertObject:_label atIndex:0];
}
- (void)insertPage:(GTKWidget *)_page
  withLabel:(GTKWidget *)_label
  atIndex:(gint)_idx {
  
  gtk_notebook_insert_page((GtkNotebook *)gtkObject,
                           [_page  gtkWidget],
                           [_label gtkWidget],
                           _idx);
  [self _primaryInsertSubWidget:_page atIndex:_idx];
  if (labels == nil) labels = [[NSMutableArray alloc] initWithCapacity:8];
  [labels insertObject:_label atIndex:_idx];
}

- (void)removePageAtIndex:(gint)_idx {
  [[subWidgets objectAtIndex:_idx] setSuperWidget:nil];
  gtk_notebook_remove_page((GtkNotebook *)gtkObject, _idx);
  [subWidgets removeObjectAtIndex:_idx];
  [labels     removeObjectAtIndex:_idx];
}
- (void)removePage:(GTKWidget *)_page {
  [self removePageAtIndex:[subWidgets indexOfObject:_page]];
}

- (void)showPageAtIndex:(gint)_idx {
  gtk_notebook_set_page((GtkNotebook *)gtkObject, _idx);
}
- (void)showPage:(GTKWidget *)_page {
  [self showPageAtIndex:[subWidgets indexOfObject:_page]];
}

- (gint)indexOfCurrentPage {
  return gtk_notebook_current_page((GtkNotebook *)gtkObject);
}
- (GTKWidget *)currentPage {
  return [subWidgets objectAtIndex:[self indexOfCurrentPage]];
}

- (void)appendPage:(GTKWidget *)_page withTitle:(NSString *)_title {
  if (subWidgets == nil) subWidgets = [[NSMutableArray alloc] initWithCapacity:8];
  if (labels == nil) labels = [[NSMutableArray alloc] initWithCapacity:8];
  
  [self appendPage:_page withLabel:[GTKLabel labelWithTitle:_title]];
}
- (void)prependPage:(GTKWidget *)_page withTitle:(NSString *)_title {
  if (subWidgets == nil) subWidgets = [[NSMutableArray alloc] initWithCapacity:8];
  if (labels == nil) labels = [[NSMutableArray alloc] initWithCapacity:8];
  
  [self prependPage:_page withLabel:[GTKLabel labelWithTitle:_title]];
}

// container support

- (void)addSubWidget:(GTKWidget *)_widget {
  [self appendPage:_widget
        withTitle:[NSString stringWithFormat:@"Page %i", [subWidgets count] + 1]];
}
- (void)removeSubWidget:(GTKWidget *)_widget {
  [self removePage:_widget];
}

// actions

- (void)nextPage:(id)sender {
  gtk_notebook_next_page((GtkNotebook *)gtkObject);
}
- (void)previousPage:(id)sender {
  gtk_notebook_prev_page((GtkNotebook *)gtkObject);
}

// private

- (GtkNotebook *)gtkNotebook {
  return (GtkNotebook *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_notebook_get_type();
}

- (BOOL)doesNeedTimer {
  return ((GtkNotebook *)gtkObject)->need_timer;
}
- (BOOL)isScrollable {
  return ((GtkNotebook *)gtkObject)->scrollable;
}
- (guint32)notebookTimer {
  return ((GtkNotebook *)gtkObject)->timer;
}
- (gint16)tabBorder {
  return ((GtkNotebook *)gtkObject)->tab_border;
}

@end
