/*
   MainController.m

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

// $Id: MainController.m,v 1.5 1998/08/10 02:13:32 helge Exp $

#import <GTKKit/GTKKit.h>
#import "MainController.h"
#import "GTKWidget+LogHierachy.h"

@implementation MainController

- (void)dealloc {
  RELEASE(buttons);      buttons = nil;
  RELEASE(fixedButtons); fixedButtons = nil;
  RELEASE(checkButtons); checkButtons = nil;
  RELEASE(menuWindow);   menuWindow   = nil;
  [super dealloc];
}

// accessors

- (void)setButtons:(GTKWindow *)_window {
  ASSIGN(buttons, _window);
}
- (void)setFixedButtons:(GTKWindow *)_window {
  ASSIGN(fixedButtons, _window);
}
- (void)setCheckButtons:(GTKWindow *)_window {
  ASSIGN(checkButtons, _window);
}

- (void)setMenuWindow:(GTKWindow *)_window {
  ASSIGN(menuWindow, _window);
}

// application delegate

- (void)applicationDidFinishLaunching:(NSNotification *)_notification {
  NSLog(@"app did finish launching ..");

  //[buttons      printWidgetHierachyWithIndent:2];
  //[fixedButtons printWidgetHierachyWithIndent:2];
  //[checkButtons printWidgetHierachyWithIndent:2];

  [menuWindow printWidgetHierachyWithIndent:2];
  [menuWindow orderFront:nil];
}

@end
