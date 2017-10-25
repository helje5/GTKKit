// $Id: GTKPixmap.m,v 1.3 1998/08/16 13:59:12 helge Exp $

/*
   GTKPixmap.m

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
#import <GDKKit/GDKPixmap.h>
#import "GTKPixmap.h"

@implementation GTKPixmap

+ (id)pixmapWithImage:(GDKPixmap *)_pixmap mask:(GDKPixmap *)_mask {
  return AUTORELEASE([[self alloc] initWithImage:_pixmap mask:_mask]);
}

- (id)init {
  return [self initWithImage:nil mask:nil];
}
- (id)initWithImage:(GDKPixmap *)_image mask:(GDKPixmap *)_mask {
  return [self initWithGtkObject:(GtkObject *)gtk_pixmap_new([_image gdkPixmap],
                                                             [_mask  gdkPixmap])];
}

#if !LIB_FOUNDATION_LIBRARY
- (void)dealloc {
  RELEASE(self->image); self->image = nil;
  RELEASE(self->mask);  self->mask  = nil;
  [super dealloc];
}
#endif

// accessors

- (void)setImage:(GDKPixmap *)_pixmap {
  ASSIGN(self->image, _pixmap);
  
  gtk_pixmap_set((GtkPixmap *)gtkObject,
                 [_pixmap gdkPixmap], [self->mask gdkPixmap]);
}
- (GDKPixmap *)image {
  return self->image;
}

- (void)setMask:(GDKPixmap *)_pixmap {
  ASSIGN(self->mask, _pixmap);
  
  gtk_pixmap_set((GtkPixmap *)gtkObject,
                 [self->image gdkPixmap], [_pixmap gdkPixmap]);
}
- (GDKPixmap *)mask {
  return self->mask;
}

// private

- (GtkPixmap *)gtkPixmap {
  return (GtkPixmap *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_pixmap_get_type();
}

// description

- (NSString *)description {
  return [NSString stringWithFormat:
                     @"<%s[0x%08X] %@ image=%@ mask=%@ %@>",
                     [[self class] name], gtkObject,
                     [self frameDescription],
                     [self image], [self mask],
                     [self alignDescription]
                   ];
}

@end
