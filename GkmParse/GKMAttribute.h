/*
   GKMAttribute.h

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

// $Id: GKMAttribute.h,v 1.1 1998/08/07 08:19:38 helge Exp $

#import <Foundation/NSObject.h>

@class NSString;

@interface GKMAttribute : NSObject
{
  NSString *text;
  int      token;
}

+ (id)attributeWithToken:(int)_token text:(NSString *)_text;
- (id)initWithToken:(int)_token text:(NSString *)_text;

// accessors

- (NSString *)text;
- (int)token;

@end

typedef GKMAttribute *Attrib;

static inline void _gkm_create_attr(Attrib *_attribute, int _token, char *_text) {
  *_attribute = [[GKMAttribute alloc]
                               initWithToken:_token
                               text:[NSString stringWithCString:_text]];
}

static inline void _gkm_delete_attr(Attrib *_attribute) {
  RELEASE(*_attribute);
  *_attribute = nil;
}

#define zzcr_attr      _gkm_create_attr
#define zzd_attr       _gkm_delete_attr
#define zzdef0(attrib) { *(attrib) = nil; }
