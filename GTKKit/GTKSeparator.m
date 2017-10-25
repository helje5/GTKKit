/*
   GTKSeparator.m

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

// $Id: GTKSeparator.m,v 1.5 1998/08/16 14:03:44 helge Exp $

#import "common.h"
#import "GTKSeparator.h"
#import "GTKBox.h"

@implementation GTKSeparator

+ (id)horizontalSeparator {
  return [GTKHorizSeparator horizontalSeparator];
}
+ (id)verticalSeparator {
  return [GTKVertSeparator verticalSeparator];
}

- (id)initWithGtkObject:(GtkObject *)_object {
  if ((self = [super initWithGtkObject:_object])) {
    [self setLayout:[GTKBoxLayoutInfo layoutWithNoExpand]];
  }
  return self;
}

// private

- (GtkSeparator *)gtkSeparator {
  return (GtkSeparator *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_separator_get_type();
}

@end

@implementation GTKHorizSeparator

+ (id)horizontalSeparator {
  return [[[self alloc] init] autorelease];
}
- (id)init {
  return [self initWithGtkObject:(GtkObject *)gtk_hseparator_new()];
}

// private

- (GtkHSeparator *)gtkHSeparator {
  return (GtkHSeparator *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_hseparator_get_type();
}

@end

@implementation GTKVertSeparator

+ (id)verticalSeparator {
  return [[[self alloc] init] autorelease];
}
- (id)init {
  return [self initWithGtkObject:(GtkObject *)gtk_vseparator_new()];
}

// private

- (GtkVSeparator *)gtkVSeparator {
  return (GtkVSeparator *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_vseparator_get_type();
}

@end
