/*
   GTKAccelLabel.m

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

// $Id: GTKAccelLabel.m,v 1.2 1998/08/16 13:59:07 helge Exp $

#import "common.h"
#import "GTKAccelLabel.h"

@implementation GTKAccelLabel

- (id)initWithTitle:(NSString *)_title { // designated initializer
  return [self initWithGtkObject:(GtkObject *)gtk_accel_label_new([_title cString])];
}

// properties

- (void)setAcceleratorWidget:(GTKWidget *)_widget {
  NSAssert(gtkObject != NULL, @"gtk widget is null");
  NSAssert(_widget,           @"accel widget is nil");

  // WARNING: needs to keep ref to accel
  gtk_accel_label_set_accel_widget((GtkAccelLabel *)gtkObject,
                                   [_widget gtkWidget]);
}

- (guint)acceleratorWidth {
  NSAssert(gtkObject != NULL, @"gtk widget is null");
  return gtk_accel_label_accelerator_width((GtkAccelLabel *)gtkObject);
}

// operation

- (void)refetch:(id)_sender {
  NSAssert(gtkObject != NULL, @"gtk widget is null");
  gtk_accel_label_refetch((GtkAccelLabel *)gtkObject);
}

// private

- (GtkAccelLabel *)gtkAccelLabel {
  return (GtkAccelLabel *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_accel_label_get_type();
}

// description

- (NSString *)description {
  return [NSString stringWithFormat:
                     @"<%s[0x%08X] %@ title='%@' justification=%@ %@>",
                     [[self class] name], gtkObject,
                     [self frameDescription], [self title],
                     GTKJustificationDescription([self justification]),
                     [self alignDescription]
                   ];
}

@end
