/*
   GTKListItem.m

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

// $Id: GTKListItem.m,v 1.5 1998/08/05 19:08:58 helge Exp $

#import "common.h"
#import "GTKListItem.h"
#import "GTKLabel.h"

@implementation GTKListItem

+ (id)listItem {
  return AUTORELEASE([[self alloc] init]);
}
+ (id)listItemWithTitle:(NSString *)_title {
  return AUTORELEASE([[self alloc] initWithTitle:_title]);
}
- (id)init {
  return [self initWithGtkObject:(GtkObject *)gtk_list_item_new()];
}
- (id)initWithTitle:(NSString *)_title {
  if ((self = [self init])) {
    GTKLabel *label = [GTKLabel labelWithTitle:_title];
    [label setAlignment:0.0:0.5];
    [self setContentWidget:label];
  }
  return self;
}

#if !LIB_FOUNDATION_BOEHM_GC
- (void)dealloc {
  RELEASE(representedObject);
  representedObject = nil;
  [super dealloc];
}
#endif

// accessors

- (void)setRepresentedObject:(id)_obj {
  ASSIGN(representedObject, _obj);
}
- (id)representedObject {
  return representedObject;
}

// actions

- (void)selectItem:(id)_sender {
  gtk_list_item_select((GtkListItem *)gtkObject);
}
- (void)deselectItem:(id)_sender {
  gtk_list_item_deselect((GtkListItem *)gtkObject);
}

// private

- (GtkListItem *)gtkListItem {
  return (GtkListItem *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_list_item_get_type();
}

@end
