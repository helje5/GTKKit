// $Id: GTKPixmap.h,v 1.2 1998/08/16 13:49:02 helge Exp $

/*
   GTKPixmap.h

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

#include <gtk/gtkpixmap.h>
#import <GTKKit/GTKMiscWidget.h>

@class GDKPixmap;

@interface GTKPixmap : GTKMiscWidget
{
  GDKPixmap *image;
  GDKPixmap *mask;
}

+ (id)pixmapWithImage:(GDKPixmap *)_pixmap mask:(GDKPixmap *)_mask;
- (id)initWithImage:(GDKPixmap *)_image mask:(GDKPixmap *)_mask;

// accessors

- (void)setImage:(GDKPixmap *)_pixmap;
- (GDKPixmap *)image;
- (void)setMask:(GDKPixmap *)_pixmap;
- (GDKPixmap *)mask;

// private

- (GtkPixmap *)gtkPixmap;
+ (guint)typeIdentifier;

@end
