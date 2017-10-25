/*
   GTKWidget.h

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

// $Id: GTKWidget.h,v 1.9 1998/08/07 08:19:05 helge Exp $

#include <gtk/gtkwidget.h>
#import <GTKKit/GTKObject.h>

@class NSData, NSString;
@class GDKWindow;
@class GTKWindow, GTKContainer, GTKLayoutInfo;

/*
  Signal mappings:
    show            => widgetDidShow:
    hide            => widgetDidHide:
    map             => widgetDidMap:
    unmap           => widgetDidUnmap:
    realize         => widgetDidRealize:
    unrealize       => widgetDidUnrealize:
    focus_in_event  => widgetGotFocus:
    focus_out_event => widgetLostFocus:
 */

@interface GTKWidget : GTKObject
{
  GTKContainer *superWidget;   // not retained, to avoid cycles
  BOOL         didRunLateInit;
  int          tag;

  // layout information
  GTKLayoutInfo *layout;

  // associated windows
  GDKWindow *window;
  GDKWindow *parentWindow;
}

// running late initialization

- (void)runLateInitialization;
- (void)storeLateAttributes;

// showing

- (void)show;
- (void)showAll;
- (void)hide;
- (void)hideAll;

- (void)show:(id)_sender;
- (void)hide:(id)_sender;

// layout information

- (void)setLayout:(GTKLayoutInfo *)_layout;
- (GTKLayoutInfo *)layout;

// tag

- (void)setTag:(int)_tag;
- (int)tag;

// widget hierachy

- (void)setSuperWidget:(GTKContainer *)_super;
- (GTKContainer *)superWidget;
- (void)removeFromSuperWidget;
- (GTKWindow *)window;

// properties

- (void)setWidgetName:(NSString *)_name;
- (NSString *)widgetName;

- (void)setSize:(gint)_width:(gint)_height;
- (void)setPosition:(gint)_x:(gint)_y;

- (int)desiredWidth;
- (int)desiredHeight;
- (int)leftEdge;
- (int)topEdge;
- (int)width;
- (int)height;

// drag'n'drop (check for memory leaks !
// the arrays are arrays of MIME-types

- (void)enableDraggingOfTypes:(NSArray *)_types;
- (void)disableDraggingOfTypes:(NSArray *)_types;
- (void)enableDroppingOfTypes:(NSArray *)_types isDestructive:(BOOL)_flag;
- (void)disableDroppingOfTypes:(NSArray *)_types;
- (void)setDraggingData:(NSData *)_data forEvent:(GdkEvent *)_event;

// state

- (BOOL)isVisible;
- (BOOL)isMapped;
- (BOOL)isRealized;
- (BOOL)isSensitive;
- (BOOL)isParentSensitive;
- (BOOL)hasNoWindow;
- (BOOL)hasFocus;
- (BOOL)canHaveFocus;
- (BOOL)hasGrab;
- (BOOL)isDrawable;

// notifications

- (void)selfPostNotification:(NSString *)_name delegateSelector:(SEL)_sel;

// application tool tips

- (void)setToolTip:(NSString *)_tip;

// description

- (NSString *)frameDescription;
- (NSString *)description;

// private

- (GtkWidget *)gtkWidget;
+ (guint)typeIdentifier;

@end

@interface GTKWidget(widgetEvents)

- (void)widgetDidShow:(GTKSignalEvent *)_event;
- (void)widgetDidHide:(GTKSignalEvent *)_event;
- (void)widgetDidMap:(GTKSignalEvent *)_event;
- (void)widgetDidUnmap:(GTKSignalEvent *)_event;
- (void)widgetDidRealize:(GTKSignalEvent *)_event;
- (void)widgetDidUnrealize:(GTKSignalEvent *)_event;
- (void)widgetGotFocus:(GTKSignalEvent *)_event;
- (void)widgetLostFocus:(GTKSignalEvent *)_event;

- (void)widgetGotSizeRequest:(GTKSignalEvent *)_event;  // size_request
- (void)widgetGotSizeAllocate:(GTKSignalEvent *)_event; // size_allocate

@end
