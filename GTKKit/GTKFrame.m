/*
   GTKFrame.m

   Copyright (C) 1998 Helge Hess.
   All rights reserved.

   Author: Unknown
           Helge Hess <helge@mdlink.de>

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

// $Id: GTKFrame.m,v 1.2 1998/07/10 10:57:38 helge Exp $

#import "GTKFrame.h"

@implementation GTKFrame

+ (id)frame {
  return [[[self alloc] init] autorelease];
}
+ (id)frameWithTitle:(NSString *)_title {
  return [[[self alloc] initWithTitle:_title] autorelease];
}
+ (id)frameWithTitle:(NSString *)_title content:(GTKWidget *)_widget {
  GTKFrame *frame = [[self alloc] initWithTitle:_title];
  [frame setContentWidget:_widget];
  return [frame autorelease];
}

- (id)init {
  return [self initWithTitle:nil];
}
- (id)initWithTitle:(NSString*)_title {
  return [self initWithGtkObject:(GtkObject *)gtk_frame_new([_title cString])];
}

// accessors

- (void)setTitle:(NSString*)aTitle {
  gtk_frame_set_label((GtkFrame*)gtkObject,[aTitle cString]);
}
- (NSString *)title {
  return nil;
}

// private

- (GtkFrame *)gtkFrame {
  return (GtkFrame *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_frame_get_type();
}

@end
