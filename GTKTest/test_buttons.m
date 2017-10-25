/*
   test_buttons.m
  
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
// $Id: test_buttons.m,v 1.2 1998/07/13 12:39:45 helge Exp $

#import <Foundation/Foundation.h>
#import <GTKKit/GTKKit.h>
#import "test_make_window.h"

@implementation GTKWidget(ToggleHideShow)

- (void)toggleHideShow:(id)_sender {
  // if the widget is visible, hide otherwise show
  if (GTK_WIDGET_VISIBLE(gtkObject)) [self hide:_sender];
  else [self show:_sender];
}

@end

typedef GTKButton *GTKButtonPtr;
static GTKButtonPtr buttons[9];

id makeButtonWindow(NSString *_title, id _ctrl) {
  GTKWindow *window = makeTestWindowWithTitle(_title);
  GTKBox    *rootBox;
  GTKTable  *table;
  GTKButton *button;

  rootBox = [GTKBox verticalBoxWithSpacing:0 sameSize:NO];
  [window setContentWidget:rootBox];

  table = [GTKTable tableWithSize:3:3 sameSize:NO];
  [table setBorderWidth:10];
  [table setRowSpacings:5];
  [table setColumnSpacings:5];
  [rootBox addSubWidget:table];

  // buttons
  {
    GTKTableLayoutInfo *layout;
    int cnt;

    // construct buttons, attach the toggleHideShow: action,
    // which is send to the buttons target
    for (cnt = 1; cnt <= 9; cnt++) {
      button = [GTKButton buttonWithTitle:
                            [NSString stringWithFormat:@"button%i", cnt]];
      [button setAction:@selector(toggleHideShow:)];
      buttons[cnt - 1] = button;
    }

    // connect each button to it's successor, so that button 0
    // controls button 1, button 1 controls button 2 and so on
    for (cnt = 0; cnt < 8; cnt++)
      [buttons[cnt] setTarget:buttons[cnt + 1]];
    [buttons[8] setTarget:buttons[0]];

    // Add buttons to table, for usage of table look into gtk+
    // documentation. The order of the parameter differs slightly
    // in GTKTable, but the meaning is the same.

    // diagonal from left/top to right/bottom
    [buttons[0] setLayout:[GTKTableLayoutInfo cellFrom:0:0 to:1:1]];
    [table addSubWidget:buttons[0]];

    [buttons[1] setLayout:[GTKTableLayoutInfo cellFrom:1:1 to:2:2]];
    [table addSubWidget:buttons[1]];

    [buttons[2] setLayout:[GTKTableLayoutInfo cellFrom:2:2 to:3:3]];
    [table addSubWidget:buttons[2]];

    // right top
    [buttons[3] setLayout:[GTKTableLayoutInfo cellFrom:0:2 to:1:3]];
    [table addSubWidget:buttons[3]];

    // left bottom
    [buttons[4] setLayout:[GTKTableLayoutInfo cellFrom:2:0 to:3:1]];
    [table addSubWidget:buttons[4]];
    
    [buttons[5] setLayout:[GTKTableLayoutInfo cellFrom:1:2 to:2:3]];
    [table addSubWidget:buttons[5]];

    [buttons[6] setLayout:[GTKTableLayoutInfo cellFrom:1:0 to:2:1]];
    [table addSubWidget:buttons[6]];

    [buttons[7] setLayout:[GTKTableLayoutInfo cellFrom:2:1 to:3:2]];
    [table addSubWidget:buttons[7]];

    [buttons[8] setLayout:[GTKTableLayoutInfo cellFrom:0:1 to:1:2]];
    [table addSubWidget:buttons[8]];
  }

  [rootBox addSubWidget:[GTKSeparator horizontalSeparator]];
  [rootBox addSubWidget:makeOrderOutButton(window)];
  return window;
}
