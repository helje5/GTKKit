/*
   GTKColorSelection.h

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

// $Id: GTKColorSelection.h,v 1.3 1998/08/06 02:08:35 helge Exp $

#include <gtk/gtkvbox.h>
#include <gtk/gtkcolorsel.h>

#import <GTKKit/GTKBox.h>
#import <GTKKit/GTKControl.h>

@class GDKColor;

@interface GTKColorSelection : GTKVertBox  < GTKControl >
{
  id       target;
  SEL      action;
  gdouble  color[4];
  GDKColor *gdkColor;
}

+ (id)colorSelectionDialog:(NSString *)aTitle;
+ (id)colorSelection;

- (id)initDialog:(NSString *)aTitle;;

- (void)setGdkColor:(GdkColor *)_color; 

- (void)takeColorFrom:(id)_sender;

- (void)setColor:(gdouble *)_color;
- (gdouble *)color;

// private

- (GtkColorSelection *)gtkColorSelection;
+ (guint)typeIdentifier;

@end
