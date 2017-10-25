/*
   GDKWindow.m

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

// $Id: GDKWindow.m,v 1.10 1998/08/06 17:23:00 helge Exp $

#import "common.h"
#import "GDKWindow.h"
#import "GDKColor.h"
#import "GDKColorMap.h"
#import "GDKVisual.h"
#import "GDKGfxContext.h"

@implementation GDKWindow

+ (id)windowWithParent:(GDKWindow *)_parent
  attributes:(GdkWindowAttr *)_attributes
  mask:(gint)_attributesMask {

  return AUTORELEASE([[self alloc] initWithParent:_parent
                                   attributes:_attributes mask:_attributesMask]);
}

- (id)initWithParent:(GDKWindow *)_parent
  attributes:(GdkWindowAttr *)_attributes
  mask:(gint)_attributesMask {

  if ((self = [super init])) {
    gdkWindow = gdk_window_new([_parent gdkWindow], _attributes, _attributesMask);
    gdk_window_set_user_data(gdkWindow, (gpointer)self);
  }
  return self;
}

- (id)initWithForeignId:(guint32)_id {
  if ((self = [super init])) {
    gdkWindow = gdk_window_foreign_new(_id);
    gdk_window_set_user_data(gdkWindow, (gpointer)self);
  }
  return self;
}

- (void)dealloc {
  if (gdkWindow) {
    gdk_window_destroy(gdkWindow);
    gdkWindow = NULL;
  }
  RELEASE(userInfo);
  [super dealloc];
}

// properties

- (void)setUserInfo:(id)_info {
  ASSIGN(userInfo, _info);
}
- (id)userInfo {
  return userInfo;
}

- (GdkWindowType)windowType {
  return gdk_window_get_type(gdkWindow);
}
- (BOOL)isRootWindow {
  return (gdk_window_get_type(gdkWindow) == GDK_WINDOW_ROOT);
}
- (BOOL)isTopLevelWindow {
  return (gdk_window_get_type(gdkWindow) == GDK_WINDOW_TOPLEVEL);
}
- (BOOL)isDialog {
  return (gdk_window_get_type(gdkWindow) == GDK_WINDOW_DIALOG);
}
- (BOOL)isPixmap {
  return (gdk_window_get_type(gdkWindow) == GDK_WINDOW_PIXMAP);
}

- (gint)depth {
  gint x, y, w, h, depth;
  gdk_window_get_geometry(gdkWindow, &x, &y, &w, &h, &depth);
  return depth;
}

- (void)setOverrideRedirect:(BOOL)_flag {
  gdk_window_set_override_redirect(gdkWindow, _flag);
}

- (void)setTitle:(NSString *)_title {
  gdk_window_set_title(gdkWindow, [_title cString]);
}
- (void)setIconTitle:(NSString *)_title {
  gdk_window_set_icon_name(gdkWindow, (char *)[_title cString]);
}

- (void)setBackgroundColor:(GDKColor *)_color {
  gdk_window_set_background(gdkWindow, [_color gdkColor]);
}
- (void)setDecorations:(GdkWMDecoration)_decorations {
  gdk_window_set_decorations(gdkWindow, _decorations);
}
- (void)setWMFunctions:(GdkWMFunction)_functions {
  gdk_window_set_functions(gdkWindow, _functions);
}

- (GDKVisual *)visual {
  return [GDKVisual visualForGdkVisual:gdk_window_get_visual(gdkWindow)];
}
- (GDKColorMap *)colorMap {
  //GdkColormap *map = gdk_window_get_colormap(gdkWindow);
  // not completed
  return nil;
}

// X window tree

- (GDKWindow *)parentWindow {
  return parentWindow;
}

- (GDKWindow *)topLevelWindow {
  // this works only if a GDKWindow was already created for the toplevel window
  return GDKGetWindow(gdk_window_get_toplevel(gdkWindow));
}

- (void)setGroupLeader:(GDKWindow *)_leader {
  gdk_window_set_group(gdkWindow, [_leader gdkWindow]);
}

// frame management

- (void)setPosition:(GDKCoord)_x:(GDKCoord)_y {
  gdk_window_move(gdkWindow, _x, _y);
}
- (void)getPosition:(GDKCoord *)_x:(GDKCoord *)_y {
  gdk_window_get_position(gdkWindow, _x, _y);
}

- (void)setSize:(GDKCoord)_width:(GDKCoord)_height {
  gdk_window_resize(gdkWindow, _width, _height);
}
- (void)getSize:(GDKCoord *)_width:(GDKCoord *)_height {
  gdk_window_get_size(gdkWindow, _width, _height);
}

- (void)setHintPosition:(GDKCoord)_x:(GDKCoord)_y
  minSize:(GDKCoord)_minWidth:(GDKCoord)_minHeight
  maxSize:(GDKCoord)_maxWidth:(GDKCoord)_maxHeight
  flags:(gint)_flags {

  gdk_window_set_hints(gdkWindow, _x, _y,
                       _minWidth, _minHeight,
                       _maxWidth, _maxHeight,
                       _flags);
}

- (BOOL)getOriginAtPosition:(GDKCoord *)_x:(GDKCoord *)_y {
  return gdk_window_get_origin(gdkWindow, _x, _y);
}

// events

- (void)setEventMask:(GdkEventMask)_mask {
  gdk_window_set_events(gdkWindow, _mask);
}

- (GdkEventMask)eventMask {
  return gdk_window_get_events(gdkWindow);
}

// operations

- (void)show {
  gdk_window_show(gdkWindow);
}
- (void)hide {
  gdk_window_hide(gdkWindow);
}
- (void)withdraw {
  gdk_window_withdraw(gdkWindow);
}

- (void)raise {
  gdk_window_raise(gdkWindow);
}
- (void)lower {
  gdk_window_lower(gdkWindow);
}

// graphic operations

- (void)clear {
  gdk_window_clear(gdkWindow);
}
- (void)clearFrom:(GDKCoord)_x:(GDKCoord)_y
  size:(GDKCoord)_width:(GDKCoord)_height expose:(BOOL)_flag {
  
  if (_flag)
    gdk_window_clear_area_e(gdkWindow, _x, _y, _width, _height);
  else
    gdk_window_clear_area(gdkWindow, _x, _y, _width, _height);
}

- (void)copyToGfxContext:(GDKGfxContext *)_target
  fromPosition:(GDKCoord)_sx:(GDKCoord)_sy toPosition:(GDKCoord)_dx:(GDKCoord)_dy
  size:(GDKCoord)_width:(GDKCoord)_height {

  gdk_window_copy_area([[_target drawable] gdkDrawable], [_target gdkGC], _dx, _dy,
                       gdkWindow, _sx, _sy,
                       _width, _height);
}

// Drag & Drop

- (void)setDragTypes:(NSArray *)_types {
  if (_types) {
    int   typeCount = [_types count];
    gchar *cstrs[typeCount];
    int   cnt;

    for (cnt = 0; cnt < typeCount; cnt++)
      cstrs[cnt] = (gchar *)[[[_types objectAtIndex:cnt] stringValue] cString];

    gdk_window_dnd_drag_set(gdkWindow, YES, cstrs, typeCount);
  }
  else
    gdk_window_dnd_drag_set(gdkWindow, NO, NULL, 0);
}

- (void)setDropTypes:(NSArray *)_types destructive:(BOOL)_isDestructiveOp {
  if (_types) {
    int   typeCount = [_types count];
    gchar *cstrs[typeCount];
    int   cnt;

    for (cnt = 0; cnt < typeCount; cnt++)
      cstrs[cnt] = (gchar *)[[[_types objectAtIndex:cnt] stringValue] cString];

    gdk_window_dnd_drop_set(gdkWindow, YES, cstrs, typeCount, _isDestructiveOp);
  }
  else
    gdk_window_dnd_drop_set(gdkWindow, NO, NULL, 0, _isDestructiveOp);
}

- (void)addWindowToDragOperation {
  gdk_dnd_drag_addwindow(gdkWindow);
}

+ (void)setDragDefaultCursor:(GdkCursor *)_defCursor
  andGoAheadCursor:(GdkCursor *)_goAheadCursor {

  gdk_dnd_set_drag_cursors(_defCursor, _goAheadCursor);
}

+ (void)setDragDefaultShape:(GDKWindow *)_defPixmapWin hotSpot:(GdkPoint *)_defSpot
  andGoAheadShape:(GDKWindow *)_gaPixmapWin hotSpot:(GdkPoint *)_gaSpot {

  gdk_dnd_set_drag_shape([_defPixmapWin gdkWindow], _defSpot,
                         [_gaPixmapWin  gdkWindow], _gaSpot);
}

// private

- (GdkWindow *)gdkWindow {
  return gdkWindow;
}
- (GdkDrawable *)gdkDrawable {
  return (GdkDrawable *)gdkWindow;
}

- (void)addFilter:(GdkFilterFunc)_filter userData:(gpointer)_data {
  gdk_window_add_filter(gdkWindow, _filter, _data);
}
- (void)removeFilter:(GdkFilterFunc)_filter userData:(gpointer)_data {
  gdk_window_remove_filter(gdkWindow, _filter, _data);
}

- (void)shapeCombineMask:(GdkBitmap *)_shapeMask offset:(GDKCoord)_x:(GDKCoord)_y {
  /*
   * This allows for making shaped (partially transparent) windows
   * - cool feature, needed for Drag and Drag for example.
   *  The shape_mask can be the mask
   *  from gdk_pixmap_create_from_xpm.   Stefan Wille
   */
  gdk_window_shape_combine_mask(gdkWindow, _shapeMask, _x, _y);
}

- (void)setBackgroundPixmap:(GdkPixmap *)_pixmap isParentRelative:(BOOL)_flag {
  gdk_window_set_back_pixmap(gdkWindow, _pixmap, _flag);
}

- (void)setCursor:(GdkCursor *)_cursor {
  gdk_window_set_cursor(gdkWindow, _cursor);
}

- (void)setIconWindow:(GDKWindow *)_icon pixmap:(GdkPixmap *)_pm mask:(GdkBitmap *)_bm {
  gdk_window_set_icon(gdkWindow, [_icon gdkWindow], _pm, _bm);
}

// description

- (NSString *)frameDescription {
  int le, te, w, h;

  [self getPosition:&le:&te];
  [self getSize:&w:&h];
  
  return [NSString stringWithFormat:@"[%i,%i %ix%i]", le, te, w, h];
}

- (NSString *)description {
  return [NSString stringWithFormat:
                     @"<Window: gdk=0x%08X frame=%@ userInfo=%@>",
                     [self gdkWindow],
                     [self frameDescription],
                     userInfo
                   ];
}

@end
