/*
   GTKMenuItem.h

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

// $Id: GTKMenuItem.h,v 1.3 1998/08/15 14:51:19 helge Exp $

#include <gtk/gtkmenuitem.h>
#import <GTKKit/GTKItem.h>
#import <GTKKit/GTKControl.h>

@class GTKMenu;

/*
  This represents a menu item. The subwidgets of an item are the widgets which
  are displayed as the name of the item.
  To add sub-items to an item you have to create an GTKMenu object and then
  attach this menu to the item by calling setSubMenu:.

  A separator (a line which splits menugroups) can be created by creating an empty
  menu item.
*/

@interface GTKMenuItem : GTKItem < GTKControl >
{
  id      target;
  SEL     action;
  GTKMenu *subMenu;
}

+ (id)menuItem;
+ (id)menuItemWithTitle:(NSString *)_title;
- (id)init;
- (id)initWithTitle:(NSString *)_title;

// properties

- (void)setShowsToggleIndicator:(BOOL)_flag;
- (BOOL)doesShowToggleIndicator;
- (void)setShowsSubMenuIndicator:(BOOL)_flag;
- (BOOL)doesShowSubMenuIndicator;

- (BOOL)isRightJustified;

// submenus

- (void)setSubMenu:(GTKMenu *)_submenu;
- (GTKMenu *)subMenu;

// actions

- (void)selectItem:(id)_sender;
- (void)deselectItem:(id)_sender;
- (void)activateItem:(id)_sender;
- (void)rightJustifyItem:(id)_sender;

// private

- (GtkMenuItem *)gtkMenuItem;
+ (guint)typeIdentifier;

- (gint)menuItemTimer;

@end
