/*
   GTKOptionMenu.m

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

// $Id: GTKOptionMenu.m,v 1.2 1998/07/10 10:57:44 helge Exp $

#import "GTKKit.h"
#import "GTKOptionMenu.h"

@implementation GTKOptionMenu

+ (id)menu {
  return [[[self alloc] init] autorelease];
}
- (id)init {
  if ((self = [self initWithGtkObject:(GtkObject *)gtk_option_menu_new()])) {
    gtkmenu = [GTKMenu menu];
  }
  return self;
}

- (id)menuItem {
  GTKMenuItem *item = nil; 
  [gtkmenu appendWidget:(item = [GTKMenuItem menuItem])];
  [item show];
  return item;
}

- (id)menuItemWithTitle:(NSString*)aTitle {
  GTKMenuItem *item = nil; 
  [gtkmenu appendWidget:(item = [GTKMenuItem menuItemWithTitle:aTitle])];
  [item show];
  return item;
}

- (void)menuFinished {
  [self setMenu:gtkmenu];
}

- (void)setActiveItem:(int)aPos {
  gtk_menu_set_active((GtkMenu*)[gtkmenu gtkObject],aPos);
}

- (int)activeItem {
  int       activeItem=0;
  GtkWidget *child=NULL;
  GtkWidget *active;
  GList     *children;
  GtkMenu   *menu = (GtkMenu*)[gtkmenu gtkObject];

  active = gtk_menu_get_active(menu);
  children = GTK_MENU_SHELL (menu)->children;
    
  while (children) {
    child = children->data;
    if (child == active) break;  
    children = children->next;   
    activeItem++;
  }
  return activeItem;
}

/*
- (GTKWidget*)activeItem {
  GtkWidget *widget = gtk_menu_get_active((GtkMenu*)[gtkmenu gtkObject]);
  return nil;
}
*/

- (void)setMenu:(GTKWidget*)aMenu {
  gtk_option_menu_set_menu( (GtkOptionMenu *)gtkObject,(GtkWidget*)[aMenu gtkObject]);
}
// private

- (GtkOptionMenu *)gtkOptionMenu {
  return (GtkOptionMenu *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_option_menu_get_type();
}

@end
