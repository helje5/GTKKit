/*
   GDKFont.m

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
// $Id: GDKFont.m,v 1.5 1998/08/06 01:16:08 helge Exp $

#import "common.h"
#import "GDKFont.h"

@implementation GDKFont

static NSMutableDictionary *loadedFonts = nil;

static inline GDKFont *_findFontEqualToGdkFont(GdkFont *_gdkFont) {
  NSEnumerator *n    = [loadedFonts objectEnumerator];
  GDKFont      *font = nil;

  if (_gdkFont == NULL)
    return nil;

  while ((font = [n nextObject])) {
    if (_gdkFont == [font gdkFont])
      return font;
    
    if (gdk_font_equal(_gdkFont, [font gdkFont])) // found one
      return font;
  }
  return nil;
}

static inline GDKFont *_fontForName(NSString *_fontName) {
  GDKFont *font = nil;

  font = [loadedFonts objectForKey:_fontName];
  if (font == nil) {
    GdkFont *gdkFont = gdk_font_load([_fontName cString]);

    if (gdkFont == NULL) {
      NSLog(@"GDKKit: could not load font '%@'", _fontName);
      return nil;
    }
    else if ((font = _findFontEqualToGdkFont(gdkFont))) { // an equal font was found
      // add an entry for the existing font under the new name
      [loadedFonts setObject:font forKey:_fontName];
      NSLog(@"GDKKit: found cached font equal equal to '%@'", _fontName);
    }
    else {
      font = [[GDKFont alloc] initWithGdkFont:gdkFont];
      [loadedFonts setObject:font forKey:_fontName];
      RELEASE(font); // retained by dictionary
    }
    
    [font->knownAs addObject:_fontName];
  }
  return font;
}
static inline GDKFont *_fontSetForName(NSString *_setName) {
  GDKFont *fontSet = nil;

  fontSet = [loadedFonts objectForKey:_setName];
  if (fontSet == nil) {
    GdkFont *gdkFontSet = gdk_fontset_load((char *)[_setName cString]);

    if (gdkFontSet == NULL) {
      NSLog(@"GDKKit: could not load fontset '%@'", _setName);
      return nil;
    }
    else if ((fontSet = _findFontEqualToGdkFont(gdkFontSet))) { // an equal font was found
      // add an entry for the existing font under the new name
      [loadedFonts setObject:fontSet forKey:_setName];
      NSLog(@"GDKKit: found cached font equal equal to fontset '%@'", _setName);
    }
    else {
      fontSet = [[GDKFont alloc] initWithGdkFont:gdkFontSet];
      [loadedFonts setObject:fontSet forKey:_setName];
      RELEASE(fontSet); // retained by dictionary
    }

    [fontSet->knownAs addObject:_setName];
  }
  return fontSet;
}

// the class

+ (void)initialize {
  static BOOL isInitialized = NO;
  if (!isInitialized) {
    isInitialized = YES;

    loadedFonts = [[NSMutableDictionary alloc] initWithCapacity:64];
  }
}

+ (GDKFont *)fontWithName:(NSString *)_fontName {
  return _fontForName(_fontName);
}
+ (GDKFont *)fontSetWithName:(NSString *)_fontSetName {
  return _fontSetForName(_fontSetName);
}

- (id)initWithGdkFont:(GdkFont *)_font {
  if ((self = [super init])) {
    gdkFont = gdk_font_ref(_font);
    knownAs = [[NSMutableArray alloc] initWithCapacity:8];
  }
  return self;
}

- (void)dealloc {
  if (gdkFont) {
    gdk_font_unref(gdkFont);
    gdkFont = NULL;
  }
  RELEASE(knownAs); knownAs = nil;
  [super dealloc];
}

// accessors

- (BOOL)isFontSet {
  return (gdkFont->type == GDK_FONT_FONTSET);
}

// metrics

- (float)widthOfString:(NSString *)_string {
  return (float)gdk_text_width(gdkFont, [_string cString], [_string cStringLength]);
}
- (float)measureOfString:(NSString *)_string {
  return (float)gdk_text_measure(gdkFont, [_string cString], [_string cStringLength]);
}
- (float)heightOfString:(NSString *)_string {
  return (float)gdk_text_height(gdkFont, [_string cString], [_string cStringLength]);
}

- (float)widthOfCharacter:(unichar)_c {
  NSAssert(_c <= 255, @"does not support unicode yet ..");
  return (float)gdk_char_width(gdkFont, _c);
}
- (float)measureOfCharacter:(unichar)_c {
  NSAssert(_c <= 255, @"does not support unicode yet ..");
  return (float)gdk_char_measure(gdkFont, _c);
}
- (float)heightOfCharacter:(unichar)_c {
  NSAssert(_c <= 255, @"does not support unicode yet ..");
  return (float)gdk_char_height(gdkFont, _c);
}

- (float)ascent {
  return gdkFont->ascent;
}
- (float)descent {
  return gdkFont->descent;
}

// comparing

- (BOOL)isEqualToFont:(GDKFont *)_font {
  return gdk_font_equal(gdkFont, [_font gdkFont]) ? YES : NO;
}

// private

+ (GDKFont *)fontForGdkFont:(GdkFont *)_gdkFont {
  // this create an unnamed font !
  GDKFont *font = _findFontEqualToGdkFont(_gdkFont);

  if (font == nil) {
    font = [[GDKFont alloc] initWithGdkFont:_gdkFont];

    font = AUTORELEASE(font);
  }
  return font;
}

- (GdkFont *)gdkFont {
  return gdkFont;
}

// description

- (NSString *)fontNames {
  NSMutableString *fontNames = [NSMutableString stringWithCapacity:256];
  NSEnumerator    *names     = [knownAs objectEnumerator];
  NSString        *fontName  = nil;
  BOOL            isFirst    = YES;

  while ((fontName = [names nextObject])) {
    if (isFirst) isFirst = NO;
    else [fontNames appendString:@", "];

    [fontNames appendString:fontName];
  }
  return fontNames;
}

- (NSString *)description {
  return [NSString stringWithFormat:
                     @"<Font: gdk=0x%08X ascend=%.0g descend=%.0g knownAs=%@>",
                     [self gdkFont],
                     [self ascent], [self descent],
                     [self fontNames]
                   ];
}

@end
