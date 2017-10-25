/*
   GTKLabel.h

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

// $Id: GTKLabel.h,v 1.4 1998/07/14 13:30:16 helge Exp $

#include <gtk/gtklabel.h>
#import <GTKKit/GTKMiscWidget.h>

@interface GTKLabel : GTKMiscWidget
{
}

+ (id)labelWithTitle:(NSString *)_title;
+ (id)labelWithTitle:(NSString *)_title justification:(GtkJustification)_mode;
+ (id)labelWithTitle:(NSString *)_title alignment:(gfloat)_xAlign:(gfloat)_yAlign;
- (id)initWithTitle:(NSString *)_title;

// accessors

- (void)setTitle:(NSString *)_title;
- (NSString *)title;

- (void)setJustification:(GtkJustification)_mode;
- (GtkJustification)justification;

// values

- (void)setStringValue:(NSString *)_string; // sets the title
- (NSString *)stringValue;                  // gets the title

- (void)setIntValue:(int)_value;
- (int)intValue;
- (void)setFloatValue:(float)_value;
- (float)floatValue;
- (void)setDoubleValue:(double)_value;
- (double)doubleValue;

// private

- (GtkLabel *)gtkLabel;
+ (guint)typeIdentifier;

@end
