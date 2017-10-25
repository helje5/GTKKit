/*
   test_toggle_buttons.m
  
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
// $Id: test_toggle_buttons.m,v 1.2 1998/07/13 12:39:47 helge Exp $

#import <Foundation/Foundation.h>
#import <GTKKit/GTKKit.h>
#import "test_make_window.h"

id makeToggleButtonWindow(NSString *_title, id _ctrl) {
  GTKWindow *window = makeTestWindowWithTitle(_title);
  GTKBox    *rootBox;
  GTKBox    *box;

  rootBox = [GTKBox verticalBoxWithSpacing:0 sameSize:NO];
  [window setContentWidget:rootBox];

  box = [GTKBox verticalBoxWithSpacing:10 sameSize:NO];
  [box setBorderWidth:10];
  [rootBox addSubWidget:box];

  [box addSubWidget:[GTKToggleButton buttonWithTitle:@"button1"]];
  [box addSubWidget:[GTKToggleButton buttonWithTitle:@"button2"]];
  [box addSubWidget:[GTKToggleButton buttonWithTitle:@"button3"]];

  [rootBox addSubWidget:[GTKSeparator horizontalSeparator]];
  [rootBox addSubWidget:makeOrderOutButton(window)];
  return window;
}
