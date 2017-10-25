/*
   GTKTreeItem.h

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

// $Id: GTKTreeItem.h,v 1.3 1998/08/04 07:56:54 helge Exp $

#include <gtk/gtktreeitem.h>
#import <GTKKit/GTKItem.h>

@class GTKTree;

@interface GTKTreeItem : GTKItem
{
  GTKTree *subTree;
}

+ (id)treeItem;
+ (id)treeItemWithTitle:(NSString *)_title;
- (id)init;
- (id)initWithTitle:(NSString *)_title;

// setting the subtree

- (void)setSubTree:(GTKTree *)_tree;
- (GTKTree *)subTree;

// the tree it belongs to (superWidget)

- (GTKTree *)tree;

// actions

- (void)expandItem:(id)_sender;
- (void)collapseItem:(id)_sender;
- (void)selectItem:(id)_sender;
- (void)deselectItem:(id)_sender;

// pathes (returns pathes like in NSBrowser)

- (NSString *)pathComponent; // calls [contentWidget stringValue]
- (NSString *)path;

// private

- (GtkTreeItem *)gtkTreeItem;
+ (guint)typeIdentifier;

@end
