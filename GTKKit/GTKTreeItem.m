/*
   GTKTreeItem.m

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

// $Id: GTKTreeItem.m,v 1.3 1998/08/04 07:56:54 helge Exp $

#import "common.h"
#import "GTKTreeItem.h"
#import "GTKLabel.h"
#import "GTKTree.h"

@implementation GTKTreeItem

+ (id)treeItem {
  return AUTORELEASE([[self alloc] init]);
}
+ (id)treeItemWithTitle:(NSString *)_title {
  return AUTORELEASE([[self alloc] initWithTitle:_title]);
}

- (id)init {
  return [self initWithGtkObject:(GtkObject *)gtk_tree_item_new()];
}
- (id)initWithTitle:(NSString *)_title {
  if ((self = [self init])) {
    GTKLabel *label = [GTKLabel labelWithTitle:_title];
    [label setAlignment:0.0:0.5];
    [self setContentWidget:label];
  }
  return self;
}

#if !LIB_FOUNDATION_BOEHM_GC
- (void)dealloc {
  RELEASE(subTree); subTree = nil;
  [super dealloc];
}
#endif

// the tree it belongs to (superWidget)

- (GTKTree *)tree {
  return (GTKTree *)[self superWidget];
}

// setting a sub-tree

- (void)setSubTree:(GTKTree *)_tree {
  NSAssert(gtkObject != NULL, @"gtk widget is null");
  NSAssert(_tree,             @"sub tree is nil");

  if (subTree) {
    gtk_tree_item_remove_subtree((GtkTreeItem *)gtkObject);
    RELEASE(subTree);
    subTree = nil;
  }
  
  gtk_tree_item_set_subtree((GtkTreeItem *)gtkObject, [_tree gtkWidget]);
  subTree = RETAIN(_tree);
}

- (GTKTree *)subTree {
  return subTree;
}

// actions

- (void)expandItem:(id)_sender {
  gtk_tree_item_expand((GtkTreeItem *)gtkObject);
}
- (void)collapseItem:(id)_sender {
  gtk_tree_item_collapse((GtkTreeItem *)gtkObject);
}

- (void)selectItem:(id)_sender {
  gtk_tree_item_select((GtkTreeItem *)gtkObject);
}
- (void)deselectItem:(id)_sender {
  gtk_tree_item_deselect((GtkTreeItem *)gtkObject);
}

// pathes (returns pathes like in NSBrowser)

- (NSString *)pathComponent { // assumes content is a label
  return [(GTKLabel *)[self contentWidget] stringValue];
}
- (NSString *)path {
  if (subTree)
    return [subTree path];
  else
    return [[[self tree] path] stringByAppendingPathComponent:[self pathComponent]];
}

// private

- (GtkTreeItem *)gtkTreeItem {
  return (GtkTreeItem *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_tree_item_get_type();
}

@end
