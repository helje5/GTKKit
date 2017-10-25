/*
   GTKFixed.m

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

// $Id: GTKFixed.m,v 1.6 1998/08/16 13:49:00 helge Exp $

#import "common.h"
#import "GTKFixed.h"

@implementation GTKFixedLayoutInfo

- (id)initWithPoint:(gint16)_x:(gint16)_y {
  if ((self = [super init])) {
    self->x = _x;
    self->y = _y;
  }
  return self;
}
- (id)init {
  return [self initWithPoint:0:0];
}

+ (id)layoutAtPoint:(gint16)_x:(gint16)_y {
  return AUTORELEASE([[self alloc] initWithPoint:_x:_y]);
}

// accessors

- (gint16)x {
  return x;
}
- (gint16)y {
  return y;
}

// description

- (NSString *)description {
  return [NSString stringWithFormat:@"<FixedLayout[0x%08X]: x=%i y=%i>",
                     (unsigned)self,
                     [self x], [self y]];
}

@end

@implementation GTKFixed

+ (id)fixed {
  return [[[self alloc] init] autorelease];
}
- (id)init {
  return [self initWithGtkObject:(GtkObject *)gtk_fixed_new()];
}

// subwidgets

- (void)addSubWidget:(GTKWidget *)_widget {
  GTKFixedLayoutInfo *info = [_widget layout];

  NSAssert([info isKindOfClass:[GTKFixedLayoutInfo class]],
           @"invalid widget layout for container");
  
  gtk_fixed_put((GtkFixed *)gtkObject, [_widget gtkWidget], [info x], [info y]);
  [self _primaryAddSubWidget:_widget];
}

// private

- (GtkFixed *)gtkFixed {
  return (GtkFixed *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_fixed_get_type();
}

@end
