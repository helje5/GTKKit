/*
   GDKGfxContext.h

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

// $Id: GDKGfxContext.h,v 1.14 1998/08/06 17:22:58 helge Exp $

#import <gdk/gdktypes.h>
#import <Foundation/NSObject.h>
#import <GDKKit/GDKTypes.h>

/*
  GDKGfxContext wraps a gdklib graphics context. Such a wrapper owns the context, this
  is the case when the GC was created by the wrapper, or it doesn't, eg when the context
  was retrieved from a widget.
  Non-owned GCs are reference-counted as required (ref() on init and unref() on dealloc).
*/

@interface GDKGfxContext : NSObject
{
  GdkGC       *gdkGC;
  BOOL        ownsContext;
  GDKDrawable *drawable;
  GdkDrawable *gdkDrawable; // cached

  GdkGCValues valueCache;
}

+ (id)gfxContextForDrawable:(GDKDrawable *)_drawable;
+ (id)gfxContextForDrawable:(GDKDrawable *)_drawable
  values:(GdkGCValues *)_values mask:(GdkGCValuesMask)_valuesMask;

- (id)initWithDrawable:(GDKDrawable *)_drawable; // values=NULL, mask=0
- (id)initWithDrawable:(GDKDrawable *)_drawable  // designated initializer
  values:(GdkGCValues *)_values mask:(GdkGCValuesMask)_valuesMask;

// accessors

- (BOOL)ownsContext;
- (GDKDrawable *)drawable;

- (void)setSubWindowMode:(GdkSubwindowMode)_mode;
- (GdkSubwindowMode)subWindowMode;
- (void)setGraphicsExposures:(gint)_exposures; // is a flag ?
- (gint)graphicsExposures;

- (void)setFunction:(GdkFunction)_function;
- (GdkFunction)_function;

// font

- (void)setFont:(GDKFont *)_font;
- (GDKFont *)font;

// line settings

- (void)setLineWidth:(gint)_width
  lineStyle:(GdkLineStyle)_lineStyle
  capStyle:(GdkCapStyle)_capStyle
  joinStyle:(GdkJoinStyle)_joinStyle;

- (void)setLineWidth:(gint)_width;
- (gint)lineWidth;
- (void)setLineStyle:(GdkLineStyle)_style;
- (GdkLineStyle)lineStyle;
- (void)setCapStyle:(GdkCapStyle)_style;
- (GdkCapStyle)capStyle;
- (void)setJoinStyle:(GdkJoinStyle)_style;
- (GdkJoinStyle)joinStyle;

// color & fill settings

- (void)setForegroundColor:(GDKColor *)_color;
- (GDKColor *)foregroundColor;
- (void)setBackgroundColor:(GDKColor *)_color;
- (GDKColor *)backgroundColor;

- (void)setFillMode:(GdkFill)_fill;
- (GdkFill)fillMode;

// clipping

- (void)setClipOrigin:(GDKCoord)_x:(GDKCoord)_y;
- (void)getClipOrigin:(GDKCoord *)_x:(GDKCoord *)_y;
- (void)setClipPosition:(guint)_x:(guint)_y size:(guint)_width:(guint)_height;
- (void)setClipMask:(GdkBitmap *)_mask;
- (void)setClipRegion:(GdkRegion *)_region;

// copy operations

- (void)copyToGfxContext:(GDKGfxContext *)_target;
- (void)copyFromGfxContext:(GDKGfxContext *)_source;

- (void)copyFromDrawable:(GDKDrawable *)_source
  fromPosition:(GDKCoord)_sx:(GDKCoord)_sy
  toPosition:(GDKCoord)_dx:(GDKCoord)_dy
  size:(GDKCoord)_width:(GDKCoord)_height;

// drawing

- (void)drawPoint:(GDKCoord)_x:(GDKCoord)_y;
- (void)drawLineFrom:(GDKCoord)_x1:(GDKCoord)_y1 to:(GDKCoord)_x2:(GDKCoord)_y2;

- (void)drawRectangleAt:(GDKCoord)_x:(GDKCoord)_y
  size:(GDKCoord)_width:(GDKCoord)_height
  fill:(BOOL)_doFill;

- (void)drawArcAt:(GDKCoord)_x:(GDKCoord)_y
  size:(GDKCoord)_width:(GDKCoord)_height
  angle1:(float)_angle1 angle2:(float)_angle2
  fill:(BOOL)_doFill;

- (void)drawPolygonWithPoints:(GdkPoint *)_points
  count:(gint)_numberOfPoints
  fill:(BOOL)_doFill;

- (void)drawPoints:(GdkPoint *)_points count:(gint)_numberOfPoints;
- (void)drawLines:(GdkPoint *)_points count:(gint)_numberOfLines; // numPoints - 1 !!!
- (void)drawSegments:(GdkSegment *)_segments count:(gint)_numberOfSegments;

- (void)drawString:(NSString *)_string at:(GDKCoord)_x:(GDKCoord)_y
  inFont:(GDKFont *)_font;
- (void)drawString:(NSString *)_string at:(GDKCoord)_x:(GDKCoord)_y;

// to be objectified

- (void)setTilePixmap:(GdkPixmap *)_pixmap;
- (GdkPixmap *)tilePixmap;
- (void)setStipplePixmap:(GdkPixmap *)_pixmap;
- (GdkPixmap *)stipplePixmap;

- (void)drawPixmap:(GdkPixmap *)_source
  fromPosition:(GDKCoord)_sx:(GDKCoord)_sy
  toPosition:(GDKCoord)_dx:(GDKCoord)_dy
  size:(GDKCoord)_width:(GDKCoord)_height;
- (void)drawBitmap:(GdkBitmap *)_source
  fromPosition:(GDKCoord)_sx:(GDKCoord)_sy
  toPosition:(GDKCoord)_dx:(GDKCoord)_dy
  size:(GDKCoord)_width:(GDKCoord)_height;
- (void)drawImage:(GdkImage *)_source
  fromPosition:(GDKCoord)_sx:(GDKCoord)_sy
  toPosition:(GDKCoord)_dx:(GDKCoord)_dy
  size:(GDKCoord)_width:(GDKCoord)_height;

// private

- (GdkGC *)gdkGC;
- (void)getValues:(GdkGCValues *)_values;

@end
