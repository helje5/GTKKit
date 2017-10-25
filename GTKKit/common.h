/*
   common.h

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

// $Id: common.h,v 1.4 1998/08/07 08:19:05 helge Exp $

#define id _id
#include <gtk/gtk.h>
#undef id

#import <Foundation/Foundation.h>

#if LIB_FOUNDATION_LIBRARY
#import <Foundation/exceptions/GeneralExceptions.h>
#else
#include <Foundation/NSException.h>
#endif

#import <GDKKit/GDKKit.h>

#import <GTKKit/GTKSignalEvent.h>
#import <GTKKit/GTKUtilities.h>
#import <GTKKit/GTKApplication.h>

// common macros

#ifndef RELEASE
#define RELEASE(x)     [x release]
#define AUTORELEASE(x) [x autorelease]
#define RETAIN(x)      [x retain]
#endif

#ifndef ASSIGN
#define ASSIGN(oldObj, newObj) \
  if (oldObj != newObj) { \
    [oldObj release]; \
    oldObj = [newObj retain]; \
  }
#endif
