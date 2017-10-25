/*
   GDKColor.h

   Copyright (C) 1998 Helge Hess.
   All rights reserved.

   Author: Helge Hess <helge@mdlink.de>

   This file is part of GDKKit.

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

// $Id: GDKColor.h,v 1.5 1998/08/05 20:53:24 helge Exp $

#import <gdk/gdktypes.h>
#import <Foundation/NSObject.h>

@interface GDKColor : NSObject < NSCopying >
{
  GdkColor gdkColor;
  struct {
    float red;
    float green;
    float blue;
  } psColor;
}

+ (id)colorWithDeviceRed:(float)_red green:(float)_green blue:(float)_blue;
+ (id)colorWithString:(NSString *)_colorString; // parses colors like #RRGGBB

// accessors

- (float)redComponent;
- (float)greenComponent;
- (float)blueComponent;

// description

- (NSString *)stringValue; // returns 2-byte-each string (like #RRRRGGGGBBBB)

// private

- (id)initWithGdkColor:(GdkColor *)_gdkColor;
- (GdkColor *)gdkColor;

@end
