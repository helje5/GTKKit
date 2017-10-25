/*
   GDKPixmap.m

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

// $Id: GDKPixmap.m,v 1.3 1998/08/06 17:51:07 helge Exp $

#import "common.h"
#import "GDKPixmap.h"
#import "GDKWindow.h"
#import "GDKColor.h"

@implementation GDKPixmap

+ (id)pixmapForWindow:(GDKWindow *)_window
  size:(GDKCoord)_width:(GDKCoord)_height depth:(int)_depth {

  return AUTORELEASE([[self alloc]
                            initWithWindow:_window size:_width:_height depth:_depth]);
}

+ (id)bitmapForWindow:(GDKWindow *)_window fromData:(NSData *)_data
  size:(GDKCoord)_width:(GDKCoord)_height {

  return AUTORELEASE([[self alloc]
                            initWithWindow:_window fromData:_data size:_width:_height]);
}

+ (id)pixmapForWindow:(GDKWindow *)_window fromData:(NSData *)_data
  size:(GDKCoord)_width:(GDKCoord)_height depth:(int)_depth
  foregroundColor:(GDKColor *)_fg backgroundColor:(GDKColor *)_bg {

  return AUTORELEASE([[self alloc]
                            initWithWindow:_window fromData:_data
                            size:_width:_height depth:_depth
                            foregroundColor:_fg backgroundColor:_bg]);
}

- (id)initWithWindow:(GDKWindow *)_window
  size:(GDKCoord)_width:(GDKCoord)_height depth:(int)_depth {

  if ((self = [super init])) {
    width  = _width;
    height = _height;
    depth  = _depth;

    gdkPixmap = gdk_pixmap_new([_window gdkWindow], width, height, depth);
    NSAssert(gdkPixmap, @"could not create pixmap");
  }
  return self;
}

- (id)initWithWindow:(GDKWindow *)_window fromData:(NSData *)_data
  size:(GDKCoord)_width:(GDKCoord)_height {

  if ((self = [super init])) {
    width  = _width;
    height = _height;
    depth  = 1;

    gdkPixmap = (GdkPixmap *)gdk_bitmap_create_from_data([_window gdkWindow],
                                                         (void *)[_data bytes],
                                                         _width, _height);
    NSAssert(gdkPixmap, @"could not create bitmap from data");
  }
  return self;
}

- (id)initWithWindow:(GDKWindow *)_window fromData:(NSData *)_data
  size:(GDKCoord)_width:(GDKCoord)_height depth:(int)_depth
  foregroundColor:(GDKColor *)_fg backgroundColor:(GDKColor *)_bg {

  if ((self = [super init])) {
    width  = _width;
    height = _height;
    depth  = _depth;

    gdkPixmap = (GdkPixmap *)gdk_pixmap_create_from_data([_window gdkWindow],
                                                         (void *)[_data bytes],
                                                         width, height, depth,
                                                         [_fg gdkColor],
                                                         [_bg gdkColor]);
    NSAssert(gdkPixmap, @"could not create pixmap from data");
  }
  return self;
}

- (void)dealloc {
  if (gdkPixmap) {
    gdk_pixmap_unref(gdkPixmap);
    gdkPixmap = NULL;
  }
  [super dealloc];
}

// accessors

- (void)getSize:(GDKCoord *)_width:(GDKCoord *)_height {
  *_width  = width;
  *_height = height;
}
- (int)depth {
  return depth;
}

- (BOOL)isBitmap {
  return (depth == 1);
}

// private

- (GdkPixmap *)gdkPixmap {
  return gdkPixmap;
}
- (GdkBitmap *)gdkBitmap {
  return (GdkBitmap *)gdkPixmap;
}
- (GdkDrawable *)gdkDrawable {
  return (GdkDrawable *)gdkPixmap;
}

// description

- (NSString *)description {
  return [NSString stringWithFormat:
                     @"<%s: gdk=0x%08X size=[%ix%i] depth=%i>",
                     [self isBitmap] ? "Bitmap" : "Pixmap",
                     [self gdkPixmap],
                     width, height, depth
                   ];
}

@end
