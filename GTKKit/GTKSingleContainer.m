/*
   GTKSingleContainer.m

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

// $Id: GTKSingleContainer.m,v 1.1 1998/07/09 06:07:40 helge Exp $

#import "GTKKit.h"
#import "GTKSingleContainer.h"

@implementation GTKSingleContainer

// accessors

- (void)addSubWidget:(GTKWidget *)_widget {
  NSLog(@"you tried adding %@ to %@ using addSubWidget:, "
        @"%s is a GTKSingleContainer, please use setContentWidget: instead.",
        _widget, self, [[self class] name]);
  [self setContentWidget:_widget];
}

- (void)setContentWidget:(GTKWidget *)_widget {
  while ([subWidgets count] > 0)
    [self removeSubWidget:[subWidgets lastObject]];

  if (_widget) [super addSubWidget:_widget];
}

- (GTKWidget *)contentWidget {
  return ([subWidgets count] > 0) ? [subWidgets lastObject] : nil;
}

// private

- (GtkBin *)gtkBin {
  return (GtkBin *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_bin_get_type();
}

@end
