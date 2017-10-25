/*
   GTKAlignment.m

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

// $Id: GTKAlignment.m,v 1.2 1998/08/16 13:59:07 helge Exp $

#import "common.h"
#import "GTKAlignment.h"

@implementation GTKAlignment

+ (id)alignmentWithScale:(gfloat)_xScale:(gfloat)_yScale
  alignment:(gfloat)_xAlign:(gfloat)_yAlign {
  return AUTORELEASE([[self alloc] initWithScale:_xScale:_yScale
                                   alignment:_xAlign:_yAlign]);
}
+ (id)alignmentWithScale:(gfloat)_xScale:(gfloat)_yScale {
  return AUTORELEASE([[self alloc] initWithScale:_xScale:_yScale alignment:0.0:0.0]);
}
+ (id)alignmentWithAlignment:(gfloat)_xAlign:(gfloat)_yAlign {
  return AUTORELEASE([[self alloc] initWithScale:0.0:0.0 alignment:_xAlign:_yAlign]);
}

- (id)initWithScale:(gfloat)_xScale:(gfloat)_yScale
  alignment:(gfloat)_xAlign:(gfloat)_yAlign {

  return [self initWithGtkObject:
                 (GtkObject *)gtk_alignment_new(_xAlign, _yAlign, _xScale, _yScale)];
}

// accessors

- (gfloat)xScale {
  return ((GtkAlignment *)gtkObject)->xscale;
}
- (gfloat)yScale {
  return ((GtkAlignment *)gtkObject)->yscale;
}

- (gfloat)xAlign {
  return ((GtkAlignment *)gtkObject)->xalign;
}
- (gfloat)yAlign {
  return ((GtkAlignment *)gtkObject)->yalign;
}

// private

- (GtkAlignment *)gtkAlignment {
  return (GtkAlignment *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_alignment_get_type();
}

@end
