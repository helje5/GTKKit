/*
   common.h

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
// $Id: common.h,v 1.3 1998/08/05 18:36:43 helge Exp $

// common includes files

#include <gdk/gdktypes.h>
#include <gdk/gdk.h>

#import <Foundation/Foundation.h>

#ifndef RELEASE
#define RELEASE(__obj__)          [__obj__ release]
#define AUTORELEASE(__obj__)      [__obj__ autorelease]
#define RETAIN(__obj__)           [__obj__ retain]

#define ASSIGN(__old__, __new__) \
  if (__old__ != __new) { \
    id tmp = _old; \
    __old__ = [__new__ retain]; \
    [__old__ release]; __old__ = nil; \
  }

#endif
