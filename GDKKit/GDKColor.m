/*
   GDKColor.m

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

// $Id: GDKColor.m,v 1.6 1998/08/06 17:22:57 helge Exp $

#import "common.h"
#import "GDKColor.h"

@implementation GDKColor

- (id)initWithGdkColor:(GdkColor *)_gdkColor {
  if ((self = [super init])) {
    memcpy(&gdkColor, _gdkColor, sizeof(GdkColor));
    psColor.red   = ((float)gdkColor.red   / 65535.0);
    psColor.green = ((float)gdkColor.green / 65535.0);
    psColor.blue  = ((float)gdkColor.blue  / 65535.0);
  }
  return self;
}

- (id)initWithDeviceRed:(float)_red green:(float)_green blue:(float)_blue {
  if ((self = [super init])) {
    psColor.red    = _red;
    psColor.green  = _green;
    psColor.blue   = _blue;
    gdkColor.red   = (gushort)(_red   * 65535.0);
    gdkColor.green = (gushort)(_green * 65535.0);
    gdkColor.blue  = (gushort)(_blue  * 65535.0);
    gdkColor.pixel = ((int)(_red * 65536.0)) + ((int)(_green * 256.0)) + (int)_blue;
  }
  return self;
}

+ (id)colorWithDeviceRed:(float)_red green:(float)_green blue:(float)_blue {
  return AUTORELEASE([[self alloc] initWithDeviceRed:_red
                                   green:_green
                                   blue:_blue]);
}

+ (id)colorWithString:(NSString *)_colorString {
  GdkColor color;
  
  if (gdk_color_parse([_colorString cString], &color))
    return AUTORELEASE([[self alloc] initWithGdkColor:&color]);
  else
    return nil;
}

// accessors

- (float)redComponent {
  return psColor.red;
}
- (float)greenComponent {
  return psColor.green;
}
- (float)blueComponent {
  return psColor.blue;
}

// private

- (GdkColor *)gdkColor {
  return &gdkColor;
}

// description

- (NSString *)stringValue { // returns 2-byte-each string (like #RRRRGGGGBBBB)
  return [NSString stringWithFormat:@"#%04X%04X%04X",
                     gdkColor.red, gdkColor.green, gdkColor.blue];
}

- (NSString *)description {
  return [NSString stringWithFormat:
                     @"<Color: gdk=0x%08X>",
                     [self gdkColor]
                   ];
}

// NSCopying

- (id)copyWithZone:(NSZone *)_zone {
  GDKColor *newColor = [GDKColor allocWithZone:_zone];
  
  [newColor initWithGdkColor:&gdkColor];
  return newColor;
}

@end
