// $Id: GTKMiscWidget.h,v 1.2 1998/08/15 14:44:23 helge Exp $

/*
   GTKMiscWidget.h

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

#include <gtk/gtkmisc.h>
#import <GTKKit/GTKWidget.h>

// Subclasses include GTKLabel, GTKArrow, GTKImage, GTKPixmap

@interface GTKMiscWidget : GTKWidget
{
}

// accessors

- (void)setAlignment:(gfloat)_xAlign:(gfloat)_yAlign;
- (void)getAlignment:(gfloat *)_xAlign:(gfloat *)_yAlign;

- (void)setPadding:(gint)_xPad:(gint)_yPad;
- (void)getPadding:(gint *)_xPad:(gint *)_yPad;

// convenience accessors

- (void)setXAlignment:(float)_xAlign;
- (void)setYAlignment:(float)_yAlign;
- (float)xAlignment;
- (float)yAlignment;

// private

- (GtkMisc *)gtkMisc;
+ (guint)typeIdentifier;

// description

- (NSString *)alignDescription;
- (NSString *)description;

@end
