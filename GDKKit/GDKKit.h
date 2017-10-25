/*
   GDKKit.h

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

// $Id: GDKKit.h,v 1.6 1998/08/06 01:04:06 helge Exp $

#import <gdk/gdk.h>
#import <GDKKit/GDKTypes.h>

#import <GDKKit/GDKColor.h>
#import <GDKKit/GDKColorMap.h>
#import <GDKKit/GDKFont.h>
#import <GDKKit/GDKGfxContext.h>
#import <GDKKit/GDKScreen.h>
#import <GDKKit/GDKVisual.h>
#import <GDKKit/GDKWindow.h>

#define LINK_GDKKit static void __link_GDKKit(void) { \
    ;\
    [GDKColor      self]; \
    [GDKColorMap   self]; \
    [GDKFont       self]; \
    [GDKGfxContext self]; \
    [GDKScreen     self]; \
    [GDKVisual     self]; \
    [GDKWindow     self]; \
    __link_GDKKit(); \
  }
