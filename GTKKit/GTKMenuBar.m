/*
   GTKMenuBar.m

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

// $Id: GTKMenuBar.m,v 1.2 1998/07/10 10:57:43 helge Exp $

#import "GTKKit.h"
#import "GTKMenuBar.h"

@implementation GTKMenuBar

+ (id)menubar {
  return [[[self alloc] init] autorelease];
}
- (id)init {
  return [self initWithGtkObject:(GtkObject *)gtk_menu_bar_new()];
}

// modifying

- (void)appendWidget:(GTKWidget *)_entry {
  gtk_menu_bar_append((GtkMenuBar *)gtkObject,
                      [_entry gtkWidget]);
  [self _primaryAddSubWidget:_entry];
}

- (void)prependWidget:(GTKWidget *)_entry {
  gtk_menu_bar_prepend((GtkMenuBar *)gtkObject,
                       [_entry gtkWidget]);
  [self _primaryInsertSubWidget:_entry atIndex:0];
}

- (void)insertWidget:(GTKWidget *)_entry atIndex:(gint)_idx {
  gtk_menu_bar_insert((GtkMenuBar *)gtkObject,
                      [_entry gtkWidget],
                      _idx);
  [self _primaryInsertSubWidget:_entry atIndex:_idx];
}

// private

- (GtkMenuBar *)gtkMenuBar {
  return (GtkMenuBar *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_menu_bar_get_type();
}

@end
