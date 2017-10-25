/*
   GTKPaned.m

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

// $Id: GTKPaned.m,v 1.3 1998/08/16 13:59:12 helge Exp $

#import "common.h"
#import "GTKPaned.h"

@implementation GTKPaned

+ (id)horizontalPaned {
  return [GTKHorizPaned horizontalPaned];
}
+ (id)verticalPaned {
  return [GTKVertPaned verticalPaned];
}

- (void)dealloc {
  [widget1 release]; widget1 = nil;
  [widget2 release]; widget2 = nil;
  [super dealloc];
}

// accessors

- (void)setHandleSize:(guint16)_size {
  gtk_paned_handle_size((GtkPaned *)gtkObject, _size);
}
- (guint16)handleSize {
  return ((GtkPaned *)gtkObject)->handle_size;
}

- (void)setGutterSize:(guint16)_size {
  gtk_paned_gutter_size((GtkPaned *)gtkObject, _size);
}
- (guint16)gutterSize {
  return ((GtkPaned *)gtkObject)->gutter_size;
}

- (void)setFirstWidget:(GTKWidget *)_widget {
  if (widget1 == _widget) return;
  [widget1 removeFromSuperWidget];
  [widget1 release];
  if (_widget) {
    widget1 = [_widget retain];
    [self addSubWidget:widget1];
  }
  else widget1 = nil;
}
- (GTKWidget *)firstWidget {
  return widget1;
}

- (void)setSecondWidget:(GTKWidget *)_widget {
  if (widget2 == _widget) return;
  [widget2 removeFromSuperWidget];
  [widget2 release];
  if (_widget) {
    widget2 = [_widget retain];
    [self addSubWidget:widget2];
  }
  else widget2 = nil;
}
- (GTKWidget *)secondWidget {
  return widget2;
}

// private

- (GtkPaned *)gtkPaned {
  return (GtkPaned *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_paned_get_type();
}

@end

@implementation GTKHorizPaned

+ (id)horizontalPaned {
  return AUTORELEASE([[self alloc] init]);
}

- (id)init {
  return [self initWithGtkObject:(GtkObject *)gtk_hpaned_new()];
}

// private

- (GtkHPaned *)gtkHPaned {
  return (GtkHPaned *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_hpaned_get_type();
}

@end

@implementation GTKVertPaned

+ (id)verticalPaned {
  return AUTORELEASE([[self alloc] init]);
}
- (id)init {
  return [self initWithGtkObject:(GtkObject *)gtk_vpaned_new()];
}

// private

- (GtkVPaned *)gtkVPaned {
  return (GtkVPaned *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_vpaned_get_type();
}

@end
