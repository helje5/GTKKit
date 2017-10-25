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

// $Id: GTKMenuBar.m,v 1.4 1998/08/16 13:59:09 helge Exp $

#import "common.h"
#import "GTKMenuBar.h"

@implementation GTKMenuBar

+ (id)menubar {
  return [[[self alloc] init] autorelease];
}
- (id)init {
  return [self initWithGtkObject:(GtkObject *)gtk_menu_bar_new()];
}

// modifying

- (void)addSubWidget:(GTKWidget *)_widget {
  NSAssert(gtkObject != NULL, @"gtk widget is null");
  NSAssert(_widget,           @"sub widget is nil");

  gtk_menu_bar_append((GtkMenuBar *)gtkObject, [_widget gtkWidget]);
  [self _primaryAddSubWidget:_widget];
}
- (void)addSubWidget:(GTKWidget *)_widget atIndex:(int)_idx {
  NSAssert(gtkObject != NULL, @"gtk widget is null");
  NSAssert(_widget,           @"sub widget is nil");

  if (_idx == 0)
    gtk_menu_bar_prepend((GtkMenuBar *)gtkObject, [_widget gtkWidget]);
  else
    gtk_menu_bar_insert((GtkMenuBar *)gtkObject, [_widget gtkWidget], _idx);
  [self _primaryInsertSubWidget:_widget atIndex:_idx];
}

// private

- (GtkMenuBar *)gtkMenuBar {
  return (GtkMenuBar *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_menu_bar_get_type();
}

@end
