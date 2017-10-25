/*
   GTKDialog.m

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

// $Id: GTKDialog.m,v 1.4 1998/08/16 14:01:06 helge Exp $

#import "common.h"
#import "GTKDialog.h"
#import "GTKBox.h"

@implementation GTKDialog

+ (id)dialog {
  return [[[self alloc] init] autorelease];
}

- (id)initWithGtkObject:(GtkObject *)_obj {
  if ((self = [super initWithGtkObject:_obj])) {
    GTKVertBox *vbox = nil;
    GTKBox     *hbox = nil;
    
    [self setReleasedWhenClosed:NO];
    
    vbox = [[GTKVertBox  alloc] initWithGtkObject:
                                  (GtkObject *)((GtkDialog *)_obj)->vbox];
    hbox = [[GTKBox alloc] initWithGtkObject:
                             (GtkObject *)((GtkDialog *)_obj)->action_area];

    [self _primaryAddSubWidget:vbox];
    [self _primaryAddSubWidget:hbox];

    [vbox release];
    [hbox release];
  }
  return self;
}

- (id)init {
  GtkObject *obj = (GtkObject *)gtk_dialog_new();
  return [self initWithGtkObject:obj];
}

// signals

- (void)widgetGotFocus {
  [GTKApp _setKeyWindow:self];
}
- (void)widgetLostFocus {
  [GTKApp _setKeyWindow:nil];
}

// boxes

- (GTKBox *)verticalBox {
  return GTKGetObject(((GtkDialog *)gtkObject)->vbox);
}
- (GTKBox *)actionArea {
  return GTKGetObject(((GtkDialog *)gtkObject)->action_area);
}

// private

- (GtkDialog *)gtkDialog {
  return (GtkDialog *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_dialog_get_type();
}

@end
