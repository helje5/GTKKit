/*
   GTKApplication.h

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

// $Id: GTKApplication.h,v 1.2 1998/07/11 21:09:49 helge Exp $

#include <gtk/gtk.h>
#import <Foundation/NSObject.h>

@class NSNotification;
@class GTKTimer, GTKWindow, GTKToolTips;

@class NSMutableArray;		// jet

extern NSString *NSApplicationWillFinishLaunchingNotification;
extern NSString *NSApplicationDidFinishLaunchingNotification;
extern NSString *NSApplicationWillTerminateNotification;
extern NSString *GTKApplicationDidInitNotification;

@interface GTKApplication : NSObject
{
  NSMutableArray *windows;
  NSMutableArray *timers;
  GTKToolTips    *defaultToolTips;
  BOOL           isTerminated;
  id             delegate;

  GTKWindow      *mainWindow;
  GTKWindow      *keyWindow;
}

- (id)initWithArguments:(char **)_argv
  count:(int)_argc
  environment:(char **)_env;

// ********** runloop **********

- (void)finishLaunching;
- (void)run;
- (void)terminate:(id)sender;

- (BOOL)isRunning;

// ********** actions **********

- (BOOL)sendAction:(SEL)_action to:(id)_target from:(id)_sender;

// ********** delegate *********

- (void)setDelegate:(id)_delegate;
- (id)delegate;

// ********** windows **********

- (void)addWindow:(GTKWindow *)_window;
- (void)removeWindow:(GTKWindow *)_window;
- (void)checkForClosedWindows;

- (GTKWindow *)keyWindow;
- (GTKWindow *)mainWindow;
- (void)_setKeyWindow:(GTKWindow *)_window;
- (void)_setMainWindow:(GTKWindow *)_window;

- (BOOL)isActive;

// ********** timers ***********

- (void)addTimer:(GTKTimer *)_timer;
- (void)removeTimer:(GTKTimer *)_timer;

// ********** tooltips *********

- (GTKToolTips *)defaultToolTips;
- (void)enableToolTips:(id)sender;
- (void)disableToolTips:(id)sender;

@end

extern GTKApplication *GTKApp;

@interface NSObject(GTKAppDelegate)

- (void)applicationDidFinishLaunching:(NSNotification *)_notification;
- (void)applicationWillFinishLaunching:(NSNotification *)_notification;

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(GTKApplication *)_app;
- (BOOL)applicationShouldTerminate:(GTKApplication *)_app;
- (void)applicationWillTerminate:(NSNotification *)_notification;

@end
