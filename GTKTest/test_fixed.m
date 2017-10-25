/*
   test_fixed.m
  
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
// $Id: test_fixed.m,v 1.2 1998/07/13 12:39:46 helge Exp $

#import <Foundation/Foundation.h>
#import <GTKKit/GTKKit.h>
#import "test_make_window.h"

typedef GTKButton *GTKButtonPtr;
static GTKButtonPtr buttons[3];

id makeFixedButtonWindow(NSString *_title, id _ctrl) {
  GTKWindow *window = makeTestWindowWithTitle(_title);
  GTKBox    *rootBox;
  GTKFixed  *fixed;
  GTKButton *button;

  rootBox = [GTKBox verticalBoxWithSpacing:0 sameSize:NO];

  fixed = [GTKFixed fixed];
  [fixed setBorderWidth:10];
  [rootBox addSubWidget:fixed];

  // buttons
  {
    int cnt;

    // construct buttons, attach the toggleHideShow: action,
    // which is send to the buttons target
    for (cnt = 1; cnt <= 3; cnt++) {
      button = [GTKButton buttonWithTitle:
                            [NSString stringWithFormat:@"button%i", cnt]];
      [button setAction:@selector(toggleHideShow:)];
      buttons[cnt - 1] = button;
    }

    // connect each button to it's successor, so that button 0
    // controls button 1, button 1 controls button 2 and so on
    for (cnt = 0; cnt < 2; cnt++)
      [buttons[cnt] setTarget:buttons[cnt + 1]];
    [buttons[2] setTarget:buttons[0]];

    // Add buttons to fixed, for usage of fixed look into gtk+
    // documentation. The order of the parameter differs slightly
    // in GTKFixed, but the meaning is the same.

    [buttons[0] setLayout:[GTKFixedLayoutInfo layoutAtPoint:10:10]];
    [fixed addSubWidget:buttons[0]];
    [buttons[1] setLayout:[GTKFixedLayoutInfo layoutAtPoint:30:30]];
    [fixed addSubWidget:buttons[1]];
    [buttons[2] setLayout:[GTKFixedLayoutInfo layoutAtPoint:30:60]];
    [fixed addSubWidget:buttons[2]];
  }

  [rootBox addSubWidget:[GTKSeparator horizontalSeparator]];
  [rootBox addSubWidget:makeOrderOutButton(window)];
  [window setContentWidget:rootBox];
  return window;
}
