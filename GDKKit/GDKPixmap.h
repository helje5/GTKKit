/*
   GDKPixmap.h

   Copyright (C) 1998 Helge Hess.
   All rights reserved.

   Author: Helge Hess <helge@mdlink.de>

   This file is part of GDKKit.

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

// $Id: GDKPixmap.h,v 1.3 1998/08/06 17:51:06 helge Exp $

#import <gdk/gdktypes.h>
#import <GDKKit/GDKDrawable.h>
#import <GDKKit/GDKTypes.h>

@class NSData;

/*
  This represents an X pixmap. A pixmap is just an off-screen X-window. Not that
  this class also represents bitmaps which are a special form of a pixmap with
  a depth of one (one bit per pixel, therefore bitmap).
*/

@interface GDKPixmap : GDKDrawable
{
@protected
  GdkPixmap *gdkPixmap;
  
  GDKCoord  width;
  GDKCoord  height;
  int       depth;
}

+ (id)pixmapForWindow:(GDKWindow *)_window
  size:(GDKCoord)_width:(GDKCoord)_height depth:(int)_depth;
+ (id)bitmapForWindow:(GDKWindow *)_window fromData:(NSData *)_data
  size:(GDKCoord)_width:(GDKCoord)_height;
+ (id)pixmapForWindow:(GDKWindow *)_window fromData:(NSData *)_data
  size:(GDKCoord)_width:(GDKCoord)_height depth:(int)_depth
  foregroundColor:(GDKColor *)_fg backgroundColor:(GDKColor *)_bg;

- (id)initWithWindow:(GDKWindow *)_window
  size:(GDKCoord)_width:(GDKCoord)_height depth:(int)_depth;
- (id)initWithWindow:(GDKWindow *)_window fromData:(NSData *)_data
  size:(GDKCoord)_width:(GDKCoord)_height;
- (id)initWithWindow:(GDKWindow *)_window fromData:(NSData *)_data
  size:(GDKCoord)_width:(GDKCoord)_height depth:(int)_depth
  foregroundColor:(GDKColor *)_fg backgroundColor:(GDKColor *)_bg;

// accessors

- (void)getSize:(GDKCoord *)_width:(GDKCoord *)_height;
- (int)depth;
- (BOOL)isBitmap; // depth == 1 ?

// private

- (GdkPixmap *)gdkPixmap;
- (GdkBitmap *)gdkBitmap;

@end
