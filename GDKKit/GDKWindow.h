/*
   GDKWindow.h

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

// $Id: GDKWindow.h,v 1.11 1998/08/06 17:23:00 helge Exp $

#import <gdk/gdktypes.h>
#import <GDKKit/GDKDrawable.h>
#import <GDKKit/GDKTypes.h>

@class NSArray, NSString;

/*
  This manages an X window. The object reference of the wrapper object is stored
  in the userdata field of the GdkWindow (but it isn't retained).
*/

@class GDKWindow;

static inline GDKWindow *GDKGetWindow(GdkWindow *_gdkWindow) {
  GDKWindow *ref = nil;
  gdk_window_get_user_data(_gdkWindow, (gpointer *)&ref);
  return ref;
}

@interface GDKWindow : GDKDrawable
{
@protected
  GdkWindow *gdkWindow;

  GDKWindow *parentWindow; // not retained
  id        userInfo;      // some user object, is retained
}

+ (id)windowWithParent:(GDKWindow *)_parent
  attributes:(GdkWindowAttr *)_attributes
  mask:(gint)_attributesMask;

- (id)initWithParent:(GDKWindow *)_parent
  attributes:(GdkWindowAttr *)_attributes
  mask:(gint)_attributesMask;

- (id)initWithForeignId:(guint32)_id;

// properties

- (void)setUserInfo:(id)_info;
- (id)userInfo;

- (GdkWindowType)windowType; // ROOT, TOPLEVEL, CHILD, DIALOG, TEMP, PIXMAP, FOREIGN
- (BOOL)isRootWindow;
- (BOOL)isTopLevelWindow;
- (BOOL)isDialog;
- (BOOL)isPixmap;

- (gint)depth;

- (void)setOverrideRedirect:(BOOL)_flag;

- (void)setTitle:(NSString *)_title;
- (void)setIconTitle:(NSString *)_title;
- (void)setBackgroundColor:(GDKColor *)_color;
- (void)setDecorations:(GdkWMDecoration)_decorations;
- (void)setWMFunctions:(GdkWMFunction)_functions;

- (GDKVisual *)visual;
- (GDKColorMap *)colorMap;

// X window tree

- (GDKWindow *)parentWindow;

/* this works only if a GDKWindow was already created for the toplevel window */
- (GDKWindow *)topLevelWindow;

- (void)setGroupLeader:(GDKWindow *)_leader;

// frame management

- (void)setPosition:(GDKCoord)_x:(GDKCoord)_y;
- (void)getPosition:(GDKCoord *)_x:(GDKCoord *)_y;
- (void)setSize:(GDKCoord)_width:(GDKCoord)_height;
- (void)getSize:(GDKCoord *)_width:(GDKCoord *)_height;

- (void)setHintPosition:(GDKCoord)_x:(GDKCoord)_y
  minSize:(GDKCoord)_minWidth:(GDKCoord)_minHeight
  maxSize:(GDKCoord)_maxWidth:(GDKCoord)_maxHeight
  flags:(gint)_flags;

- (BOOL)getOriginAtPosition:(GDKCoord *)_x:(GDKCoord *)_y;

// events

- (void)setEventMask:(GdkEventMask)_mask;
- (GdkEventMask)eventMask;

// operations

- (void)show;
- (void)hide;
- (void)withdraw;

- (void)raise;
- (void)lower;

// graphic operations

- (void)clear;
- (void)clearFrom:(GDKCoord)_x:(GDKCoord)_y
  size:(GDKCoord)_width:(GDKCoord)_height
  expose:(BOOL)_flag;

- (void)copyToGfxContext:(GDKGfxContext *)_target
  fromPosition:(GDKCoord)_sx:(GDKCoord)_sy
  toPosition:(GDKCoord)_dx:(GDKCoord)_dy
  size:(GDKCoord)_width:(GDKCoord)_height;

// Drag & Drop

/*
 * Drag & Drop
 * Algorithm (drop source):
 * A window being dragged will be sent a GDK_DRAG_BEGIN message.
 * It will then do gdk_dnd_drag_addwindow() for any other windows that are to be
 * dragged.
 * When we get a DROP_ENTER incoming, we send it on to the window in question.
 * That window needs to use gdk_dnd_drop_enter_reply() to indicate the state of
 * things (it must call that even if it's not going to accept the drop)
 *
 * These two turn on/off drag or drop, and if enabling it also
 * sets the list of types supported. The list of types passed in is an array
 * if type-objects. These get send -stringValue and must return their type.
 * The list of types passed in should be in order of decreasing preference.
 * If the _types array is <nil> the operation is disabled.
 */
- (void)setDragTypes:(NSArray *)_types;
- (void)setDropTypes:(NSArray *)_types destructive:(BOOL)_flag;

/*
 * This is used by the GDK_DRAG_BEGIN handler. An example of usage would be a
 * file manager where multiple icons were selected and the drag began.
 * The icon that the drag actually began on would gdk_dnd_drag_addwindow
 * for all the other icons that were being dragged... 
 */
- (void)addWindowToDragOperation;

// private

- (GdkWindow *)gdkWindow;

- (void)addFilter:(GdkFilterFunc)_filter userData:(gpointer)_data;
- (void)removeFilter:(GdkFilterFunc)_filter userData:(gpointer)_data;

/*
 * This allows for making shaped (partially transparent) windows
 * - cool feature, needed for Drag and Drag for example.
 *  The shape_mask can be the mask
 *  from gdk_pixmap_create_from_xpm.   Stefan Wille
 */
- (void)shapeCombineMask:(GdkBitmap *)_shapeMask offset:(GDKCoord)_x:(GDKCoord)_y;

- (void)setBackgroundPixmap:(GdkPixmap *)_pixmap isParentRelative:(BOOL)_flag;
- (void)setCursor:(GdkCursor *)_cursor;

- (void)setIconWindow:(GDKWindow *)_icon pixmap:(GdkPixmap *)_pm mask:(GdkBitmap *)_bm;

// drag & drop privates
 
+ (void)setDragDefaultCursor:(GdkCursor *)_defCursor
  andGoAheadCursor:(GdkCursor *)_goAheadCursor;

+ (void)setDragDefaultShape:(GDKWindow *)_defPixmapWin hotSpot:(GdkPoint *)_defSpot
  andGoAheadShape:(GDKWindow *)_gaPixmapWin hotSpot:(GdkPoint *)_gaSpot;

@end
