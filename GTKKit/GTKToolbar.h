// $Id: GTKToolbar.h,v 1.1 1998/07/09 06:07:45 helge Exp $

/*
   GTKToolbar.h

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

#include <gtk/gtktoolbar.h>
#import <GTKKit/GTKContainer.h>

// not yet ready

@interface GTKToolbar : GTKContainer
{
}

+ (id)horizontalIconToolbar;
+ (id)verticalIconToolbar;
+ (id)horizontalTextToolbar;
+ (id)verticalTextToolbar;

+ (id)toolbarWithOrientation:(GtkOrientation)_orientation
  andStyle:(GtkToolbarStyle)_style;
- (id)initWithOrientation:(GtkOrientation)_orientation
  andStyle:(GtkToolbarStyle)_style;

// accessors

/*
  These styles are available:
    GTK_TOOLBAR_ICONS
    GTK_TOOLBAR_TEXT
    GTK_TOOLBAR_BOTH
*/
- (void)setStyle:(GtkToolbarStyle)_style;
- (GtkToolbarStyle)style;

/* either GTK_ORIENTATION_HORIZONTAL or GTK_ORIENTATION_VERTICAL */
- (void)setOrientation:(GtkOrientation)_orientation;
- (GtkOrientation)orientation;

/* big optional space between buttons */
- (void)setSpaceSize:(gint)_pixels;
- (gint)spaceSize;

// private

- (GtkToolbar *)gtkToolbar;
+ (guint)typeIdentifier;

@end
