/*
   GTKMenuShell.m

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

// $Id: GTKMenuShell.m,v 1.1 1998/07/09 06:07:31 helge Exp $

#import "GTKKit.h"
#import "GTKMenuShell.h"

@implementation GTKMenuShell

// modifying

- (void)appendWidget:(GTKWidget *)_entry {
  gtk_menu_shell_append((GtkMenuShell *)gtkObject,
                        [_entry gtkWidget]);
  [self _primaryAddSubWidget:_entry];
}

- (void)prependWidget:(GTKWidget *)_entry {
  gtk_menu_shell_prepend((GtkMenuShell *)gtkObject,
                         [_entry gtkWidget]);
  [self _primaryInsertSubWidget:_entry atIndex:0];
}

- (void)insertWidget:(GTKWidget *)_entry atIndex:(gint)_idx {
  gtk_menu_shell_insert((GtkMenuShell *)gtkObject,
                        [_entry gtkWidget],
                        _idx);
  [self _primaryInsertSubWidget:_entry atIndex:_idx];
}

// operations

- (void)deactivate {
  gtk_menu_shell_deactivate((GtkMenuShell *)gtkObject);
}

// state

- (BOOL)isActive {
  return ((GtkMenuShell *)gtkObject)->active;
}
- (BOOL)hasGrab {
  return ((GtkMenuShell *)gtkObject)->have_grab;
}
- (BOOL)hasXGrab {
  return ((GtkMenuShell *)gtkObject)->have_xgrab;
}

// private

- (GtkMenuShell *)gtkMenuShell {
  return (GtkMenuShell *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_menu_shell_get_type();
}

@end
