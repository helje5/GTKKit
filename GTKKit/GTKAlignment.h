/*
   GTKAlignment.h

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

// $Id: GTKAlignment.h,v 1.1 1998/07/14 12:23:52 helge Exp $

#include <gtk/gtkalignment.h>
#import <GTKKit/GTKSingleContainer.h>

@interface GTKAlignment : GTKSingleContainer
{
}

+ (id)alignmentWithScale:(gfloat)_xScale:(gfloat)_yScale
  alignment:(gfloat)_xAlign:(gfloat)_yAlign;
+ (id)alignmentWithScale:(gfloat)_xScale:(gfloat)_yScale;
+ (id)alignmentWithAlignment:(gfloat)_xAlign:(gfloat)_yAlign;

- (id)initWithScale:(gfloat)_xScale:(gfloat)_yScale
  alignment:(gfloat)_xAlign:(gfloat)_yAlign;

// accessors

- (gfloat)xScale;
- (gfloat)yScale;
- (gfloat)xAlign;
- (gfloat)yAlign;

// private

- (GtkAlignment *)gtkAlignment;
+ (guint)typeIdentifier;

@end
