/*
   GTKTree.m

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

// $Id: GTKTree.m,v 1.9 1998/08/04 17:55:52 helge Exp $

#import "common.h"
#import "GTKTree.h"
#import "GTKTreeItem.h"

@implementation GTKTree

+ (id)tree {
  return AUTORELEASE([[self alloc] init]);
}
- (id)init {
  return [self initWithGtkObject:(GtkObject *)gtk_tree_new()];
}

// accessors

- (void)setDelegate:(id)_delegate {
  ASSIGN(delegate, _delegate);
}
- (id)delegate {
  return delegate;
}

- (void)setSelectionMode:(GtkSelectionMode)_mode {
  gtk_tree_set_selection_mode((GtkTree *)gtkObject, _mode);
}
- (GtkSelectionMode)selectionMode {
  return ((GtkTree *)gtkObject)->selection_mode;
}

- (void)selectItemAtIndex:(gint)_idx {
  gtk_tree_select_item((GtkTree *)gtkObject, _idx);
}
- (void)deselectItemAtIndex:(gint)_idx {
  gtk_tree_unselect_item((GtkTree *)gtkObject, _idx);
}

- (void)selectItem:(GTKTreeItem *)_item {
  gtk_tree_select_child((GtkTree *)gtkObject, [_item gtkWidget]);
}
- (void)deselectItem:(GTKTreeItem *)_item {
  gtk_tree_unselect_child((GtkTree *)gtkObject, [_item gtkWidget]);
}

// tree view mode

- (void)setViewMode:(GtkTreeViewMode)_mode {
  gtk_tree_set_view_mode((GtkTree *)gtkObject, _mode);
}
- (GtkTreeViewMode)viewMode {
  return ((GtkTree *)gtkObject)->view_mode;
}

- (void)setViewLines:(BOOL)_yesno {
  gtk_tree_set_view_lines((GtkTree *)gtkObject, _yesno ? TRUE : FALSE);
}
- (BOOL)viewLines {
  return ((GtkTree *)gtkObject)->view_line;
}

// adding tree items

- (void)addSubWidget:(GTKWidget *)_widget {
  NSAssert(gtkObject != NULL, @"gtk widget is null");
  NSAssert(_widget,           @"sub widget is nil");

  gtk_tree_append((GtkTree *)gtkObject, [_widget gtkWidget]);
  [self _primaryAddSubWidget:_widget];
}

- (gint)indexOfItem:(GTKTreeItem *)_item {
  return gtk_tree_child_position((GtkTree *)gtkObject, [_item gtkWidget]);
}

- (BOOL)isRootTree {
  return GTK_IS_ROOT_TREE(gtkObject) ? YES : NO;
}
- (GTKTree *)rootTree {
  if ([self isRootTree])
    return self;
  else {
    GtkTree *tree = GTK_TREE_ROOT_TREE(gtkObject);
    return tree ? GTKGetObject(tree) : nil;
  }
}

// reloading

- (void)reloadItem:(id)_item {
}
- (void)reloadItem:(id)_item reloadChildren:(BOOL)_flag {
}

// subtree handling (item convenience methods)

- (void)expandItem:(id)_sender {
  NSAssert([superWidget isKindOfClass:[GTKTreeItem class]], @"not a subtree");
  [(GTKTreeItem *)superWidget expandItem:_sender];
}
- (void)collapseItem:(id)_sender {
  NSAssert([superWidget isKindOfClass:[GTKTreeItem class]], @"not a subtree");
  [(GTKTreeItem *)superWidget collapseItem:_sender];
}

- (GTKTree *)parentTree {
  // superWidget==treeitem, parentTree=treeitem->superWidget
  NSAssert([superWidget isKindOfClass:[GTKTreeItem class]], @"not a subtree");
  return (GTKTree *)[superWidget superWidget];
}

// pathes (returns pathes like in NSBrowser)

- (NSString *)pathComponent {
  if ([self isRootTree])
    return @"/";
  else
    return [(GTKTreeItem *)superWidget pathComponent];
}

- (NSString *)path {
  if ([self isRootTree])
    return @"/";
  else {
    return [[[self parentTree] pathComponent]
                   stringByAppendingPathComponent:[self pathComponent]];
  }
}

// private

- (GtkTree *)gtkTree {
  return (GtkTree *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_tree_get_type();
}

@end
