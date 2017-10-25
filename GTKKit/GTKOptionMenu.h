/*
   GTKOptionMenu.h

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

// $Id: GTKOptionMenu.h,v 1.1 1998/07/09 06:07:34 helge Exp $

#include <gtk/gtkoptionmenu.h>
#import <GTKKit/GTKButton.h>


@interface GTKOptionMenu : GTKButton
{
  GTKMenu *gtkmenu;
}

+ (id)menu;
- (id)init;

- (id)menuItem;
- (id)menuItemWithTitle:(NSString*)aTitle;
- (void)menuFinished;

- (void)setActiveItem:(int)aPos;
- (int)activeItem;

- (void)setMenu:(GTKWidget *)aMenu;

// private

- (GtkOptionMenu *)gtkOptionMenu;
+ (guint)typeIdentifier;

@end
