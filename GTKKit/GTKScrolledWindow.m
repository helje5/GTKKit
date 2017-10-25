/*
   GTKScrolledWindow.m

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

// $Id: GTKScrolledWindow.m,v 1.4 1998/08/16 14:03:43 helge Exp $

#import "common.h"
#import "GTKScrolledWindow.h"
#import "GTKAdjustment.h"

@implementation GTKScrolledWindow

+ (id)scrolledWindow {
  return [[[self alloc] init] autorelease];
}
+ (id)scrolledWindowWithContent:(GTKWidget *)_content {
  GTKScrolledWindow *widget = [[self alloc] init];
  [widget addSubWidget:_content];
  return AUTORELEASE(widget);
}
+ (id)scrolledWindowWithAdjustment:(GTKAdjustment *)_h:(GTKAdjustment *)_v {
  return AUTORELEASE([[self alloc] initWithAdjustment:_h:_v]);
}

- (id)init {
  return [self initWithAdjustment:nil:nil];
}
- (id)initWithGtkObject:(GtkObject *)_obj {
  if ((self = [super initWithGtkObject:_obj])) {
    RETAIN([self horizontalAdjustment]);
    RETAIN([self verticalAdjustment]);
  }
  return self;
}
- (id)initWithAdjustment:(GTKAdjustment *)_horiz:(GTKAdjustment *)_vert {
  GtkObject *obj = NULL;
  obj = (GtkObject *)gtk_scrolled_window_new([_horiz gtkAdjustment],
                                             [_vert  gtkAdjustment]);
  return [self initWithGtkObject:obj];
}

- (void)dealloc {
  if (gtkObject) {
    GTKAdjustment *horiz = [self horizontalAdjustment];
    GTKAdjustment *vert  = [self verticalAdjustment];

    RELEASE(horiz); horiz = nil;
    RELEASE(vert);  vert  = nil;
  }
  [super dealloc];
}

// accessors

- (void)setHorizScrollbarPolicy:(GtkPolicyType)_policy {
  gtk_scrolled_window_set_policy((GtkScrolledWindow *)gtkObject,
                                 _policy,
                          ((GtkScrolledWindow *)gtkObject)->vscrollbar_policy);
}
- (guint8)horizScrollbarPolicy {
  return ((GtkScrolledWindow *)gtkObject)->hscrollbar_policy;
}

- (void)setVertScrollbarPolicy:(GtkPolicyType)_policy {
  gtk_scrolled_window_set_policy((GtkScrolledWindow *)gtkObject,
                          ((GtkScrolledWindow *)gtkObject)->hscrollbar_policy,
                                 _policy);
}
- (guint8)vertScrollbarPolicy {
  return ((GtkScrolledWindow *)gtkObject)->vscrollbar_policy;
}

// adjustments

- (GTKAdjustment *)horizontalAdjustment {
  return (GTKAdjustment *)GTKGetObject(
    gtk_scrolled_window_get_hadjustment((GtkScrolledWindow *)gtkObject));
}
- (GTKAdjustment *)verticalAdjustment {
  return (GTKAdjustment *)GTKGetObject(
    gtk_scrolled_window_get_vadjustment((GtkScrolledWindow *)gtkObject));
}

// private

- (GtkScrolledWindow *)gtkScrolledWindow {
  return ((GtkScrolledWindow *)gtkObject);
}
+ (guint)typeIdentifier {
  return gtk_scrolled_window_get_type();
}

@end
