/*
   GDKGfxContext.m

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

// $Id: GDKGfxContext.m,v 1.14 1998/08/06 17:22:58 helge Exp $

#import "common.h"
#import "GDKGfxContext.h"
#import "GDKWindow.h"
#import "GDKColor.h"
#import "GDKFont.h"

@implementation GDKGfxContext

static inline void _synchronizeValueCache(GDKGfxContext *self) {
  gdk_gc_get_values(self->gdkGC, &(self->valueCache));
}

+ (id)gfxContextForDrawable:(GDKDrawable *)_drawable {
  return AUTORELEASE([[self alloc] initWithDrawable:_drawable]);
}
+ (id)gfxContextForDrawable:(GDKDrawable *)_drawable
  values:(GdkGCValues *)_values
  mask:(GdkGCValuesMask)_valuesMask {

  return AUTORELEASE([[self alloc] initWithDrawable:_drawable
                                   values:_values mask:_valuesMask]);
}

- (id)init {
  return [self initWithDrawable:nil values:NULL mask:0];
}
- (id)initWithDrawable:(GDKDrawable *)_drawable {
  return [self initWithDrawable:_drawable values:NULL mask:0];
}

- (id)initWithDrawable:(GDKDrawable *)_drawable
  values:(GdkGCValues *)_values
  mask:(GdkGCValuesMask)_valuesMask {

  if ((self = [super init])) {
    drawable    = RETAIN(_drawable);
    gdkDrawable = [drawable gdkDrawable];
    
    gdkGC  = gdk_gc_new_with_values(gdkDrawable, _values, _valuesMask);
    NSAssert(gdkGC != NULL, @"could not create graphics context");
  }
  return self;
}

- (void)dealloc {
  if (gdkGC) {
    gdk_gc_destroy(gdkGC);
    gdkGC = NULL;
  }
  RELEASE(drawable); drawable = nil; gdkDrawable = NULL;
  [super dealloc];
}

// accessors

- (BOOL)ownsContext {
  return ownsContext;
}

- (GDKDrawable *)drawable {
  return drawable;
}

- (void)setSubWindowMode:(GdkSubwindowMode)_mode {
  gdk_gc_set_subwindow(gdkGC, _mode);
}
- (GdkSubwindowMode)subWindowMode {
  _synchronizeValueCache(self);
  return valueCache.subwindow_mode;
}

- (void)setGraphicsExposures:(gint)_exposures { // is a flag ?
  gdk_gc_set_exposures(gdkGC, _exposures);
}
- (gint)graphicsExposures {
  _synchronizeValueCache(self);
  return valueCache.graphics_exposures;
}

- (void)setFunction:(GdkFunction)_function {
  gdk_gc_set_function(gdkGC, _function);
}
- (GdkFunction)_function {
  _synchronizeValueCache(self);
  return valueCache.function;
}

// fonts

- (void)setFont:(GDKFont *)_font {
  gdk_gc_set_font(gdkGC, [_font gdkFont]);
}
- (GDKFont *)font {
  _synchronizeValueCache(self);
  return [GDKFont fontForGdkFont:valueCache.font];
}

// line settings

- (void)setLineWidth:(gint)_width
  lineStyle:(GdkLineStyle)_lineStyle
  capStyle:(GdkCapStyle)_capStyle
  joinStyle:(GdkJoinStyle)_joinStyle {

  gdk_gc_set_line_attributes(gdkGC, _width, _lineStyle, _capStyle, _joinStyle);
}

- (void)setLineWidth:(gint)_width {
  _synchronizeValueCache(self);
  
  gdk_gc_set_line_attributes(gdkGC, _width,
                             valueCache.line_style,
                             valueCache.cap_style,
                             valueCache.join_style);
}
- (gint)lineWidth {
  _synchronizeValueCache(self);
  return valueCache.line_width;
}

- (void)setLineStyle:(GdkLineStyle)_style {
  _synchronizeValueCache(self);
  
  gdk_gc_set_line_attributes(gdkGC, valueCache.line_width,
                             _style,
                             valueCache.cap_style,
                             valueCache.join_style);
}
- (GdkLineStyle)lineStyle {
  _synchronizeValueCache(self);
  return valueCache.line_style;
}

- (void)setCapStyle:(GdkCapStyle)_style {
  _synchronizeValueCache(self);
  
  gdk_gc_set_line_attributes(gdkGC, valueCache.line_width,
                             valueCache.line_style,
                             _style,
                             valueCache.join_style);
}
- (GdkCapStyle)capStyle {
  _synchronizeValueCache(self);
  return valueCache.cap_style;
}

- (void)setJoinStyle:(GdkJoinStyle)_style {
  _synchronizeValueCache(self);
  
  gdk_gc_set_line_attributes(gdkGC, valueCache.line_width,
                             valueCache.line_style,
                             valueCache.cap_style,
                             _style);
}
- (GdkJoinStyle)joinStyle {
  _synchronizeValueCache(self);
  return valueCache.join_style;
}

// color & fills

- (void)setForegroundColor:(GDKColor *)_color {
  gdk_gc_set_foreground(gdkGC, [_color gdkColor]);
}
- (GDKColor *)foregroundColor {
  GDKColor *color = nil;
  
  _synchronizeValueCache(self);
  color = [[GDKColor allocWithZone:[self zone]]
                     initWithGdkColor:&(valueCache.foreground)];
  return AUTORELEASE(color);
}

- (void)setBackgroundColor:(GDKColor *)_color {
  gdk_gc_set_background(gdkGC, [_color gdkColor]);
}
- (GDKColor *)backgroundColor {
  GDKColor *color = nil;
  
  _synchronizeValueCache(self);
  color = [[GDKColor allocWithZone:[self zone]]
                     initWithGdkColor:&(valueCache.background)];
  return AUTORELEASE(color);
}

- (void)setFillMode:(GdkFill)_fill {
  gdk_gc_set_fill(gdkGC, _fill);
}
- (GdkFill)fillMode {
  _synchronizeValueCache(self);
  return valueCache.fill;
}

// clipping

- (void)setClipOrigin:(GDKCoord)_x:(GDKCoord)_y {
  gdk_gc_set_clip_origin(gdkGC, _x, _y);
}
- (void)getClipOrigin:(GDKCoord *)_x:(GDKCoord *)_y {
  _synchronizeValueCache(self);
  *_x = valueCache.clip_x_origin;
  *_y = valueCache.clip_y_origin;
}

- (void)setClipPosition:(guint)_x:(guint)_y size:(guint)_width:(guint)_height {
  GdkRectangle frame;
  
  frame.x      = _x;
  frame.y      = _y;
  frame.width  = _width;
  frame.height = _height;
  
  gdk_gc_set_clip_rectangle(gdkGC, &frame);
}

- (void)setClipMask:(GdkBitmap *)_mask {
  gdk_gc_set_clip_mask(gdkGC, _mask);
}

- (void)setClipRegion:(GdkRegion *)_region {
  gdk_gc_set_clip_region(gdkGC, _region);
}

// copy operations

- (void)copyToGfxContext:(GDKGfxContext *)_target {
  gdk_gc_copy([_target gdkGC], gdkGC);
}
- (void)copyFromGfxContext:(GDKGfxContext *)_source {
  gdk_gc_copy(gdkGC, [_source gdkGC]);
}

- (void)copyFromDrawable:(GDKDrawable *)_source
  fromPosition:(GDKCoord)_sx:(GDKCoord)_sy toPosition:(GDKCoord)_dx:(GDKCoord)_dy
  size:(GDKCoord)_width:(GDKCoord)_height {

  gdk_window_copy_area(gdkDrawable, gdkGC, _dx, _dy,
                       [_source gdkDrawable], _sx, _sy,
                       _width, _height);
}

// drawing

- (void)drawPoint:(GDKCoord)_x:(GDKCoord)_y {
  gdk_draw_point(gdkDrawable, gdkGC, _x, _y);
}
- (void)drawLineFrom:(GDKCoord)_x1:(GDKCoord)_y1 to:(GDKCoord)_x2:(GDKCoord)_y2 {
  gdk_draw_line(gdkDrawable, gdkGC, _x1, _y1, _x2, _y2);
}

- (void)drawRectangleAt:(GDKCoord)_x:(GDKCoord)_y
  size:(GDKCoord)_width:(GDKCoord)_height
  fill:(BOOL)_doFill {

  gdk_draw_rectangle(gdkDrawable, gdkGC, _doFill, _x, _y, _width, _height);
}

- (void)drawArcAt:(GDKCoord)_x:(GDKCoord)_y
  size:(GDKCoord)_width:(GDKCoord)_height
  angle1:(float)_angle1 angle2:(float)_angle2
  fill:(BOOL)_doFill {

  gdk_draw_arc(gdkDrawable, gdkGC, _doFill, _x, _y, _width, _height, _angle1, _angle2);
}

- (void)drawPolygonWithPoints:(GdkPoint *)_points count:(gint)_numberOfPoints
  fill:(BOOL)_doFill {

  gdk_draw_polygon(gdkDrawable, gdkGC, _doFill, _points, _numberOfPoints);
}

- (void)drawPoints:(GdkPoint *)_points count:(gint)_numberOfPoints {
  gdk_draw_points(gdkDrawable, gdkGC, _points, _numberOfPoints);
}

- (void)drawLines:(GdkPoint *)_points count:(gint)_numberOfLines {
  // numPoints - 1 !!!
  gdk_draw_lines(gdkDrawable, gdkGC, _points, _numberOfLines + 1);
}

- (void)drawSegments:(GdkSegment *)_segments count:(gint)_numberOfSegments {
  gdk_draw_segments(gdkDrawable, gdkGC, _segments, _numberOfSegments);
}

- (void)drawString:(NSString *)_string at:(GDKCoord)_x:(GDKCoord)_y
  inFont:(GDKFont *)_font {

  gdk_draw_text(gdkDrawable, [_font gdkFont], gdkGC, _x, _y,
                [_string cString], [_string cStringLength]);
}
- (void)drawString:(NSString *)_string at:(GDKCoord)_x:(GDKCoord)_y {
  _synchronizeValueCache(self);
  
  gdk_draw_text(gdkDrawable, valueCache.font, gdkGC, _x, _y,
                [_string cString], [_string cStringLength]);
}

// private

- (void)setTilePixmap:(GdkPixmap *)_pixmap {
  gdk_gc_set_tile(gdkGC, _pixmap);
}
- (GdkPixmap *)tilePixmap {
  _synchronizeValueCache(self);
  return valueCache.tile;
}

- (void)setStipplePixmap:(GdkPixmap *)_pixmap {
  gdk_gc_set_stipple(gdkGC, _pixmap);
}
- (GdkPixmap *)stipplePixmap {
  _synchronizeValueCache(self);
  return valueCache.stipple;
}

- (void)drawPixmap:(GdkPixmap *)_source
  fromPosition:(GDKCoord)_sx:(GDKCoord)_sy
  toPosition:(GDKCoord)_dx:(GDKCoord)_dy
  size:(GDKCoord)_width:(GDKCoord)_height {

  gdk_draw_pixmap(gdkDrawable, gdkGC, _source, _sx, _sy, _dx, _dy, _width, _height);
}
- (void)drawBitmap:(GdkBitmap *)_source
  fromPosition:(GDKCoord)_sx:(GDKCoord)_sy
  toPosition:(GDKCoord)_dx:(GDKCoord)_dy
  size:(GDKCoord)_width:(GDKCoord)_height {

  gdk_draw_pixmap(gdkDrawable, gdkGC, _source, _sx, _sy, _dx, _dy, _width, _height);
}
- (void)drawImage:(GdkImage *)_source
  fromPosition:(GDKCoord)_sx:(GDKCoord)_sy
  toPosition:(GDKCoord)_dx:(GDKCoord)_dy
  size:(GDKCoord)_width:(GDKCoord)_height {

  gdk_draw_image(gdkDrawable, gdkGC, _source, _sx, _sy, _dx, _dy, _width, _height);
}

- (GdkGC *)gdkGC {
  return gdkGC;
}

- (void)getValues:(GdkGCValues *)_values {
  return gdk_gc_get_values(gdkGC, _values);
}

// description

- (NSString *)description {
  return [NSString stringWithFormat:
                     @"<GC: gdk=0x%08X isOwner=%s drawable=%@ fg=%@ bg=%@"
                     @" lineWidth=%i"
                     @">",
                     [self gdkGC],
                     [self ownsContext] ? "YES" : "NO",
                     [self drawable],
                     [self foregroundColor], [self backgroundColor],
                     [self lineWidth]
                   ];
}

@end
