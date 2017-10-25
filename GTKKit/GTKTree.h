/*
   GTKTree.h

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

// $Id: GTKTree.h,v 1.6 1998/08/04 17:55:51 helge Exp $

#include <gtk/gtktree.h>
#import <GTKKit/GTKContainer.h>

@class GTKTreeItem;

@interface GTKTree : GTKContainer
{
  id delegate;
}

+ (id)tree;
- (id)init;

// accessors

- (void)setDelegate:(id)_delegate;
- (id)delegate;

/*
  selection_mode          selection contents
  ------------------------------------------------------
  
  GTK_SELECTION_SINGLE    selection is either empty or one element
  
  GTK_SELECTION_BROWSE    selection is NULL if the list
                          contains no widgets, otherwise
                          it contains a GList* pointer
                          for one GList structure.
  GTK_SELECTION_MULTIPLE  selection is NULL if no listitems
                          are selected or a a GList* pointer
                          for the first selected item. that
                          in turn points to a GList structure
                          for the second selected item and so
                          on
*/

- (void)setSelectionMode:(GtkSelectionMode)_mode;
- (GtkSelectionMode)selectionMode;

- (void)selectItemAtIndex:(gint)_idx;
- (void)deselectItemAtIndex:(gint)_idx;
- (void)selectItem:(GTKTreeItem *)_item;
- (void)deselectItem:(GTKTreeItem *)_item;

// tree view mode

/*
  Sets the "view mode", which can be either GTK_TREE_VIEW_LINE (the default) or
  GTK_TREE_VIEW_ITEM. The view mode propagates from a tree to its subtrees, and
  can't be set exclusively to a subtree (this is not exactly true - see the example
  code comments). 

  The term "view mode" is rather ambiguous - basically, it controls the way the
  hilight is drawn when one of a tree's children is selected. If it's
  GTK_TREE_VIEW_LINE, the entire GtkTreeItem widget is hilighted, while for
  GTK_TREE_VIEW_ITEM, only the child widget (i.e. usually the label) is hilighted.
*/

- (void)setViewMode:(GtkTreeViewMode)_mode;
- (GtkTreeViewMode)viewMode;

/*
  Controls whether connecting lines between tree items are drawn. flag is either
  YES, in which case they are, or NO, in which case they aren't.
*/
- (void)setViewLines:(BOOL)_yesno;
- (BOOL)viewLines;

// adding tree items

- (void)addSubWidget:(GTKWidget *)_widget;

- (gint)indexOfItem:(GTKTreeItem *)_item;

- (BOOL)isRootTree;
- (GTKTree *)rootTree;

// reloading

- (void)reloadItem:(id)_item;
- (void)reloadItem:(id)_item reloadChildren:(BOOL)_flag;

// subtree handling (item convenience methods)

- (void)expandItem:(id)_sender;
- (void)collapseItem:(id)_sender;
- (GTKTree *)parentTree; // superWidget==treeitem, parentTree=treeitem->superWidget

// pathes (returns pathes like in NSBrowser)

- (NSString *)pathComponent; // root='/', subtrees=item.pathComponent
- (NSString *)path;

// private

- (GtkTree *)gtkTree;
+ (guint)typeIdentifier;

@end

@interface NSObject(GTKTreeDelegate)

// _item == nil means root object

- (int)tree:(GTKTree *)_tree numberOfChildrenOfItem:(id)_item;
- (id)tree:(GTKTree *)_tree child:(int)_index ofItem:(id)_item;

@end
