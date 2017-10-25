/*
   GTKCheckButton.m

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

// $Id: GTKCheckButton.m,v 1.4 1998/07/10 12:18:24 helge Exp $

#import "common.h"
#import "GTKCheckButton.h"
#import "GTKLabel.h"

@implementation GTKCheckButton

- (id)init {
  return [self initWithGtkObject:(GtkObject *)gtk_check_button_new()];
}
- (id)initWithTitle:(NSString *)_title {
  /*
  if ((self = [self init])) {
    GTKLabel *label = [GTKLabel labelWithTitle:_title];
    [label setAlignment:0.0:0.5];
    [self addSubWidget:label];
  }
  return self;
  */
  return [self initWithGtkObject:
                 (GtkObject *)gtk_check_button_new_with_label([_title cString])];
}

// private

- (GtkCheckButton *)gtkCheckButton {
  return (GtkCheckButton *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_check_button_get_type();
}

@end
