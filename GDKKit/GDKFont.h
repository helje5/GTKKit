/*
   GDKFont.h

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

// $Id: GDKFont.h,v 1.5 1998/08/06 00:16:41 helge Exp $

#import <gdk/gdktypes.h>
#import <Foundation/NSObject.h>
#import <GDKKit/GDKTypes.h>

@class NSString, NSMutableArray;

/*
  This represents a X11 font or fontsets. Loaded fonts are never expired, they are
  cached by the class. The constructor functions look whether a font with this name
  is already loaded and if so, they return the existing object.
*/

@interface GDKFont : NSObject
{
  GdkFont *gdkFont;

  NSMutableArray *knownAs; // the names under the font was registered
}

+ (GDKFont *)fontWithName:(NSString *)_fontName;
+ (GDKFont *)fontSetWithName:(NSString *)_fontSetName;

// accessors

- (BOOL)isFontSet;

// metrics

- (float)widthOfString:(NSString *)_string;
- (float)widthOfCharacter:(unichar)_c;
- (float)measureOfString:(NSString *)_string;
- (float)measureOfCharacter:(unichar)_c;
- (float)heightOfString:(NSString *)_string;
- (float)heightOfCharacter:(unichar)_c;

- (float)ascent;
- (float)descent;

// comparing

- (BOOL)isEqualToFont:(GDKFont *)_font;

// private

+ (GDKFont *)fontForGdkFont:(GdkFont *)_font;
- (id)initWithGdkFont:(GdkFont *)_font;
- (GdkFont *)gdkFont;

@end
