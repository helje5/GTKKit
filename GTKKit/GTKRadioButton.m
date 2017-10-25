/*
   GTKRadioButton.m

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

// $Id: GTKRadioButton.m,v 1.6 1998/07/11 16:17:54 helge Exp $

#import "common.h"
#import "GTKRadioButton.h"
#import "GTKLabel.h"

@implementation GTKRadioButton

+ (id)button {
  return AUTORELEASE([[self alloc] init]);
}
+ (id)buttonAddedTo:(GTKRadioButton *)_button {
  return AUTORELEASE([[self alloc] initWithRadioButton:_button]);
}
+ (id)buttonWithTitle:(NSString *)_title {
  return AUTORELEASE([[self alloc] initWithTitle:_title]);
}
+ (id)buttonWithTitle:(NSString *)_title addedTo:(GTKRadioButton *)_button {
  return AUTORELEASE([[self alloc] initWithTitle:_title andButton:_button]);
}

- (id)initWithRadioButton:(GTKRadioButton *)_button {
  GtkObject *obj = (GtkObject *)gtk_radio_button_new([_button radioButtonGroup]);
  return [self initWithGtkObject:obj];
}

- (id)init {
  return [self initWithRadioButton:nil];
}
- (id)initWithTitle:(NSString *)_title {
  return [self initWithTitle:_title andButton:nil];
}
- (id)initWithTitle:(NSString *)_title andButton:(GTKRadioButton *)_button {
  if ((self = [self initWithRadioButton:_button])) {
    GTKLabel *label = [GTKLabel labelWithTitle:_title];
    [label setAlignment:0.0:0.5];
    [self addSubWidget:label];
  }
  return self;
}

// group

- (GSList *)radioButtonGroup {
  return gtk_radio_button_group((GtkRadioButton *)gtkObject);
}

// private

- (GtkRadioButton *)gtkRadioButton {
  return (GtkRadioButton *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_radio_button_get_type();
}

@end
