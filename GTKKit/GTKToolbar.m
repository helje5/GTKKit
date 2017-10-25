// $Id: GTKToolbar.m,v 1.4 1998/07/10 12:22:26 helge Exp $

/*
   GTKToolbar.m

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

#import "common.h"
#import "GTKToolbar.h"

@implementation GTKToolbar

+ (id)horizontalIconToolbar {
  return AUTORELEASE([[self alloc]
                            initWithOrientation:GTK_ORIENTATION_HORIZONTAL
                            andStyle:GTK_TOOLBAR_ICONS]);
}
+ (id)verticalIconToolbar {
  return AUTORELEASE([[self alloc]
                            initWithOrientation:GTK_ORIENTATION_VERTICAL
                            andStyle:GTK_TOOLBAR_ICONS]);
}
+ (id)horizontalTextToolbar {
  return AUTORELEASE([[self alloc]
                            initWithOrientation:GTK_ORIENTATION_HORIZONTAL
                            andStyle:GTK_TOOLBAR_TEXT]);
}
+ (id)verticalTextToolbar {
  return AUTORELEASE([[self alloc]
                            initWithOrientation:GTK_ORIENTATION_VERTICAL
                            andStyle:GTK_TOOLBAR_TEXT]);
}

+ (id)toolbarWithOrientation:(GtkOrientation)_orientation
  andStyle:(GtkToolbarStyle)_style {
  
  return AUTORELEASE([[self alloc]
                            initWithOrientation:_orientation
                            andStyle:_style]);
}

- (id)initWithOrientation:(GtkOrientation)_orientation
  andStyle:(GtkToolbarStyle)_style {
  
  return [self initWithGtkObject:(GtkObject *)gtk_toolbar_new(_orientation, _style)];
}

// accessors

- (void)setStyle:(GtkToolbarStyle)_style {
  gtk_toolbar_set_style((GtkToolbar *)gtkObject, _style);
}
- (GtkToolbarStyle)style {
  return ((GtkToolbar *)gtkObject)->style;
}

- (void)setOrientation:(GtkOrientation)_orientation {
  gtk_toolbar_set_orientation((GtkToolbar *)gtkObject, _orientation);
}
- (GtkOrientation)orientation {
  return ((GtkToolbar *)gtkObject)->orientation;
}

- (void)setSpaceSize:(gint)_pixels {
  gtk_toolbar_set_space_size((GtkToolbar *)gtkObject, _pixels);
}
- (gint)spaceSize {
  return ((GtkToolbar *)gtkObject)->space_size;
}

// private

- (GtkToolbar *)gtkToolbar {
  return (GtkToolbar *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_toolbar_get_type();
}

@end
