/*
   test_main_menu.m
  
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
// $Id: test_main_menu.m,v 1.7 1998/08/06 01:15:59 helge Exp $

#import <Foundation/Foundation.h>
#import <GTKKit/GTKKit.h>

static void makeMenuButtons(GTKBox *_box, id _ctrl);

id makeButtonWindow      (NSString *_title, id _ctrl);
id makeCheckButtonWindow (NSString *_title, id _ctrl);
id makeFixedButtonWindow (NSString *_title, id _ctrl);
id makeListWindow        (NSString *_title, id _ctrl);
id makeMenuTestWindow    (NSString *_title, id _ctrl);
id makeSpinButtonWindow  (NSString *_title, id _ctrl);
id makeToggleButtonWindow(NSString *_title, id _ctrl);
id makeTreeModeWindow    (NSString *_title, id _ctrl);

id makeMenuWindow(id _ctrl) {
  GTKWindow         *window;
  GTKBox            *rootBox;
  GTKBox            *buttonBox;
  GTKScrolledWindow *scrollArea;
  GTKButton         *quitButton;

  // allocate new window, this is 'releasedWhenClosed'
  window = [[GTKWindow alloc] init];

  // a window is a container, so you can set some space between it's
  // borders and it's content-widget
  [window setBorderWidth:0];

  // set the title of the window
  [window setTitle:@"ObjC gtk+ test"];

  // set position and size of window, the position is probably
  // modified by the window manager
  [window setSize:200:300];
  [window setPosition:140:120];

  // There is no need to connect the 'delete' gtk signal to
  // something, this is handled by the window-proxy which notifies
  // the application of it's close. You can set a delegate on the
  // window to prevent a close.
  // If notified the application object checks whether there
  // are open windows hanging around, otherwise it terminates.

  // Now create a vertical box with no space between the elements.
  // The elements need not to be of the same size (homogeneous
  // attribute). Note that all content widgets have a retain count
  // of zero (init/autorelease), so that they are freed, when the
  // window is freed. Also need that there is no need to realize
  // or show the widgets, all this is cached by the proxy and set
  // if it becomes real (if you are interested, look for *lateInit*
  // methods).
  rootBox = [GTKBox verticalBoxWithSpacing:0 sameSize:NO];

  // Set the box as the window's content view. The window is a single
  // container, which means that it can hold only one content widget.
  [window setContentWidget:rootBox];

  // Create a scrolled window. The name is somewhat misleading, since
  // it doesn't create a top-level window which is scrolled but a
  // scrolled area inside a real window (the name comes from the fact,
  // that an X11 window is assigned to the widget).
  // Note that you can assign an adjustment to the window.
  scrollArea = [GTKScrolledWindow scrolledWindow];

  // These calls set the space between the scrolled windows border and
  // it's contents to 10 pixels. The scrollbars of the window automatically
  // adjust to size changes of the content.
  [scrollArea setBorderWidth:10];
  [scrollArea setHorizScrollbarPolicy:GTK_POLICY_AUTOMATIC];
  [scrollArea setVertScrollbarPolicy:GTK_POLICY_AUTOMATIC];

  // This adds the scrolled window to the top-level widget, the box.
  // You can pass along with the widget some formatting parameters. You
  // can look for how these are used in GTKBox.h or the gtk+ Manuals.
  // There are also some shortcut methods in GTKBox which assume some
  // defaults.
  [rootBox addSubWidget:scrollArea];

  // We create another box for the contents of the scrolled window.
  buttonBox = [GTKBox verticalBoxWithSpacing:0 sameSize:NO];
  [scrollArea addSubWidget:buttonBox];

  // Now create and add the buttons for the various tests
  makeMenuButtons(buttonBox, _ctrl);

  // We place a separator between the scrolled window and the
  // 'quit' button.
  {
    GTKSeparator *sep = [GTKSeparator horizontalSeparator];
    [sep setLayout:[GTKBoxLayoutInfo layoutWithPadding:0 doExpand:NO doFill:YES]];
    [rootBox addSubWidget:sep];
  }

  // The 'quit' button and a surounding box is created. The box
  // is needed to provide some spacing between the window borders
  // and the button. The button is made the default button, which
  // says that the button receives input events first (so you can
  // just press 'enter' to quit invoke the button's action).
  buttonBox  = [GTKBox verticalBoxWithSpacing:10 sameSize:NO];
  [buttonBox setBorderWidth:5];
  
  quitButton = [GTKButton buttonWithTitle:@"quit"];
  [window setDefaultWidget:quitButton];

  [quitButton setLayout:[GTKBoxLayoutInfo layoutWithNoExpand]];
  [buttonBox  addSubWidget:quitButton];
  [buttonBox  setLayout:[GTKBoxLayoutInfo layoutWithNoExpand]];
  [rootBox    addSubWidget:buttonBox];

  // We need to bind some kind of action to the button. This is done
  // using the target/action thing, as used in NeXTstep/OpenStep.
  // Gtk+ would use signals here, which isn't exactly the same. Signals
  // correspond more the notifications, which are also used for delegate
  // notifications in GTKKit.
  // The target in this case is the global application object, which has
  // a method terminate: to stop the application. If the quit button is
  // clicked it sends it's action to it's target which terminates the app.
  [quitButton setTarget:GTKApp];
  [quitButton setAction:@selector(terminate:)];

  return window;
}

// We use an array of titles together with window constructor
// functions to build the test-selection buttons.
// The constructor gets the buttons title and the controller
// object and returns a GTKWindow object.

struct {
  NSString *title;
  id (*func)(NSString *title, id _ctrl);
}
buttons[] = {
  { @"buttons",        makeButtonWindow       },
  { @"toggle buttons", makeToggleButtonWindow },
  { @"check buttons",  makeCheckButtonWindow  },
  { @"fixed buttons",  makeFixedButtonWindow  },
  { @"spinbutton",     makeSpinButtonWindow   },
  { @"list",           makeListWindow         },
  { @"tree",           makeTreeModeWindow     }
  // { @"menus",          makeMenuTestWindow } jet
};

int buttonCount = sizeof(buttons) / sizeof(buttons[0]);

static void makeMenuButtons(GTKBox *_box, id _ctrl) {
  int cnt;
  GTKBoxLayoutInfo *layout = [GTKBoxLayoutInfo layoutWithNoExpandAndNoFill];

  for (cnt = 0; cnt < buttonCount; cnt++) {
    GTKButton *button = [GTKButton buttonWithTitle:buttons[cnt].title];
    id window = nil;

    // Call constructor function
    window = buttons[cnt].func(buttons[cnt].title, _ctrl);
    [window setPosition:(142 + cnt * 20):(160 + cnt * 20)];
    [GTKApp addWindow:window];

    // If the buttons is pressed, it send's orderFront: to
    // the window, which appears on the screen if it isn't
    // already on screen.
    [button setTarget:window];
    [button setAction:@selector(orderFront:)];

    // add button to the box inside the scrolled window
    [button setLayout:layout];
    [_box addSubWidget:button];
  }
}
