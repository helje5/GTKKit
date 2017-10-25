/*
   GDKVisual.h

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

// $Id: GDKVisual.h,v 1.7 1998/08/06 00:42:34 helge Exp $

#import <gdk/gdktypes.h>
#import <Foundation/NSObject.h>
#import <GDKKit/GDKTypes.h>

@class NSArray;

/*
  GDKVisual uses a mapping between GDKVisual objects and GdkVisual entries. The
  objects for the entries are created on demand. The GDKVisual objects are never
  released, they are retained until the program quits.

  GdkVisual:
  * The visual type.
  *   "type" is the type of visual this is (PseudoColor, TrueColor, etc).
  *   "depth" is the bit depth of this visual.
  *   "colormap_size" is the size of a colormap for this visual.
  *   "bits_per_rgb" is the number of significant bits per red, green and blue.
  *  The red, green and blue masks, shifts and precisions refer
  *   to value needed to calculate pixel values in TrueColor and DirectColor
  *   visuals. The "mask" is the significant bits within the pixel. The
  *   "shift" is the number of bits left we must shift a primary for it
  *   to be in position (according to the "mask"). "prec" refers to how
  *   much precision the pixel value contains for a particular primary.
*/

@interface GDKVisual : NSObject
{
  GdkVisual *gdkVisual;
}

+ (GDKVisual *)systemVisual;
+ (GDKVisual *)bestVisual;
+ (GDKVisual *)bestVisualWithDepth:(gint)_depth;
+ (GDKVisual *)bestVisualWithType:(GdkVisualType)_type;
+ (GDKVisual *)bestVisualWithDepth:(gint)_depth andType:(GdkVisualType)_type;

// class methods

+ (gint)bestVisualDepth;
+ (GdkVisualType)bestVisualType;
+ (NSArray *)allVisuals;

// accessors

- (GdkVisualType)visualType;
- (gint)depth;
- (GdkByteOrder)byteOrder;

// private

+ (GDKVisual *)visualForGdkVisual:(GdkVisual *)_gdkVisual;
- (gint)colorMapSize;
- (gint)bitsPerRGB;
- (GdkVisual *)gdkVisual;

@end
