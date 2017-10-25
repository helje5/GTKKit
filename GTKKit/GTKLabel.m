/*
   GTKLabel.m

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

// $Id: GTKLabel.m,v 1.10 1998/08/16 13:49:02 helge Exp $

#import "common.h"
#import "GTKLabel.h"

@implementation GTKLabel

+ (id)labelWithTitle:(NSString *)_title {
  return AUTORELEASE([[self alloc] initWithTitle:_title]);
}
+ (id)labelWithTitle:(NSString *)_title justification:(GtkJustification)_mode {
  GTKLabel *label = [[self alloc] initWithTitle:_title];
  [label setJustification:_mode];
  return AUTORELEASE(label);
}
+ (id)labelWithTitle:(NSString *)_title alignment:(gfloat)_xAlign:(gfloat)_yAlign {
  GTKLabel *label = [[self alloc] initWithTitle:_title];
  [label setAlignment:_xAlign:_yAlign];
  return AUTORELEASE(label);
}

- (id)initWithTitle:(NSString *)_title {
  return [self initWithGtkObject:(GtkObject *)gtk_label_new([_title cString])];
}
- (id)init {
  return [self initWithTitle:@"<untitled>"];
}

// accessors

- (void)setTitle:(NSString *)_title {
  gtk_label_set((GtkLabel *)gtkObject, [_title cString]);
}

- (NSString *)title {
  char *cstr = NULL;
  gtk_label_get((GtkLabel *)gtkObject, &cstr);
  return [NSString stringWithCString:cstr];
}

- (void)setJustification:(GtkJustification)_mode {
  gtk_label_set_justify((GtkLabel *)gtkObject, _mode);
  NSLog(@"did justify label %i", _mode);
}
- (GtkJustification)justification {
  return ((GtkLabel *)gtkObject)->jtype;
}

// values

- (void)setStringValue:(NSString *)_string {
  // sets the title
  [self setTitle:_string];
}
- (NSString *)stringValue { // gets the title
  return [self title];
}

- (void)setIntValue:(int)_value {
  [self setStringValue:[NSString stringWithFormat:@"%i", _value]];
}
- (int)intValue {
  return [[self stringValue] intValue];
}
- (void)setFloatValue:(float)_value {
  [self setStringValue:[NSString stringWithFormat:@"%f", _value]];
}
- (float)floatValue {
  return [[self stringValue] floatValue];
}
- (void)setDoubleValue:(double)_value {
  [self setStringValue:[NSString stringWithFormat:@"%f", _value]];
}
- (double)doubleValue {
  return [[self stringValue] doubleValue];
}

// private

- (GtkLabel *)gtkLabel {
  return (GtkLabel *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_label_get_type();
}

// description

- (NSString *)description {
  return [NSString stringWithFormat:
                     @"<%s[0x%08X] %@ title='%@' justification=%@ %@>",
                     [[self class] name], gtkObject,
                     [self frameDescription],
                     [self title],
                     GTKJustificationDescription([self justification]),
                     [self alignDescription]
                   ];
}

@end
