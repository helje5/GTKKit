/*
   GKMAttribute.m

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

// $Id: GKMAttribute.m,v 1.3 1998/08/10 01:13:38 helge Exp $

#import "common.h"
#import "GKMAttribute.h"

@implementation GKMAttribute

+ (id)attributeWithToken:(int)_token text:(NSString *)_text {
  return AUTORELEASE([[self alloc] initWithToken:_token text:_text]);
}

- (id)initWithToken:(int)_token text:(NSString *)_text {
  if ((self = [super init])) {
    token = _token;
    if ([_text hasPrefix:@"\""]) {
      NSRange range;
      range.location = 1;
      range.length   = [_text length] - 2;
      text = RETAIN([_text substringWithRange:range]);
    }
    else 
      text = [_text copy];
  }
  return self;
}

#if !LIB_FOUNDATION_BOEHM_GC
- (void)dealloc {
  RELEASE(text); text = nil;
  [super dealloc];
}
#endif

// accessors

- (NSString *)text {
  return text;
}
- (int)token {
  return token;
}

// description

- (NSString *)description {
  return [NSString stringWithFormat:@"<Attrib: token=%i text=%@>",
                     [self token], [self text]];
}

@end
