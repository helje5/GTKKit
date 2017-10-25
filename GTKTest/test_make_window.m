/*
   test_make_window.m
  
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
// $Id: test_make_window.m,v 1.3 1998/07/14 16:37:00 helge Exp $

#import <Foundation/Foundation.h>
#import <GTKKit/GTKKit.h>

id makeTestWindowWithTitle(NSString *_title) {
  GTKWindow *window = [[GTKWindow alloc] init];

  [window setReleasedWhenClosed:NO];

  [window setTitle:_title];
  [window setBorderWidth:0];

  return [window autorelease];
}

id makeOrderOutButton(GTKWindow *_window) {
  GTKBox    *box;
  GTKButton *button = [GTKButton buttonWithTitle:@"hide"];

  [_window setDefaultWidget:button];
  [button setTarget:_window];
  [button setAction:@selector(orderOut:)];

  box = [GTKBox verticalBoxWithSpacing:10 sameSize:NO];
  [box setBorderWidth:10];
  [button setLayout:[GTKBoxLayoutInfo layoutWithNoExpand]];
  [box addSubWidget:button];
  [box setLayout:[GTKBoxLayoutInfo layoutWithNoExpand]];
  
  return box;
}

