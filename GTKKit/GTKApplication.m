/*
   GTKApplication.m

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

// $Id: GTKApplication.m,v 1.8 1998/08/05 19:08:55 helge Exp $

#import "common.h"
#import "GTKToolTips.h"
#import "GTKWindow.h"
#import "GTKTimer.h"
#import "GTKApplication.h"

#include <Foundation/Foundation.h> // jet

NSString *NSApplicationWillFinishLaunchingNotification =
  @"NSApplicationWillFinishLaunchingNotification";
NSString *NSApplicationDidFinishLaunchingNotification =
  @"NSApplicationDidFinishLaunchingNotification";
NSString *NSApplicationWillTerminateNotification =
  @"NSApplicationWillTerminateNotification";

NSString *GTKApplicationDidInitNotification =
  @"GTKApplicationDidInitNotification";

@implementation GTKApplication

+ (void)initialize {
  static BOOL isInitialized = NO;
  if (!isInitialized) {
    isInitialized = YES;

    gtk_set_locale();
    GTKApp = nil;
  }
}

- (id)initWithArguments:(char **)_argv count:(int)_argc environment:(char **)_env {
  if ((self = [super init])) {

    windows = [[NSMutableArray alloc] initWithCapacity:16];
    isTerminated = NO;

#ifdef HAVE_LIBGLE
    gle_init(&_argc, &_argv);
#endif
  
    gtk_init(&_argc, &_argv);
    // grk_rc_parse("app.gtkrc");

    [[NSNotificationCenter defaultCenter]
                           postNotificationName:GTKApplicationDidInitNotification
                           object:self];

    defaultToolTips = [[GTKToolTips alloc] init];
    [defaultToolTips setDelay:4.0];
  }  
  return self;
}

- (void)dealloc {
  isTerminated = YES;
  RELEASE(delegate);        delegate        = nil;
  RELEASE(defaultToolTips); defaultToolTips = nil;
  RELEASE(timers);          timers          = nil;
  RELEASE(windows);         windows         = nil;
  [super dealloc];
}

// ********** runloop **********

- (void)finishLaunching {
  NSNotification *n = nil;

  // will finish launching
  n = [NSNotification notificationWithName:
                        NSApplicationWillFinishLaunchingNotification
                      object:self];
  if ([delegate respondsToSelector:@selector(applicationWillFinishLaunching:)])
    [delegate applicationWillFinishLaunching:n];
  [[NSNotificationCenter defaultCenter] postNotification:n];

  // did finish launching
  n = [NSNotification notificationWithName:
                        NSApplicationDidFinishLaunchingNotification
                      object:self];
  if ([delegate respondsToSelector:@selector(applicationDidFinishLaunching:)])
    [delegate applicationDidFinishLaunching:n];
  [[NSNotificationCenter defaultCenter] postNotification:n];
}

- (void)run {
  [self finishLaunching];
  
  while (isTerminated == NO) {
    NSAutoreleasePool *localPool = [NSAutoreleasePool new];
    gint returnValue;

    returnValue = gtk_main_iteration();
    if (returnValue == TRUE) isTerminated = YES;
    
    [localPool release];
    localPool = nil;
  }
}

- (void)terminate:sender {
  if (!isTerminated) {
    NSNotification *n;
    int  cnt, winCount;

    if ([delegate respondsToSelector:@selector(applicationShouldTerminate:)]) {
      if ([delegate applicationShouldTerminate:self] == NO) return;
    }
    
    NSLog(@"terminating application.");

    n = [NSNotification notificationWithName:
                          NSApplicationWillTerminateNotification
                        object:self];
    if ([delegate respondsToSelector:@selector(applicationWillTerminate:)])
      [delegate applicationWillTerminate:n];
    [[NSNotificationCenter defaultCenter] postNotification:n];
    
    isTerminated = YES;

    winCount = [windows count];
    for (cnt = 0; cnt < winCount; cnt++) {
      GTKWindow *window = [windows objectAtIndex:cnt];
      [window close];
    }
    winCount = [windows count];
    for (cnt = 0; cnt < winCount; cnt++)
      [self removeWindow:[windows lastObject]];
  }
}

- (BOOL)isRunning {
  return !isTerminated;
}

// ********** actions **********

- (BOOL)sendAction:(SEL)_action to:(id)_target from:(id)_sender {
  BOOL result = NO;
  
  if (_target) {
    if ([_target respondsToSelector:_action]) {
      [_target performSelector:_action withObject:_sender];
      result = YES;
    }
    else {
      NSLog(@"WARNING: target(%@) does not respond to action(%@)",
            _target, NSStringFromSelector(_action));
      result = NO;
    }
  }
  else {
    result = NO;
  }
  return result;
}

// delegate

- (void)setDelegate:(id)_delegate {
  ASSIGN(delegate, _delegate);
}
- (id)delegate {
  return delegate;
}

// windows

- (void)appWillBecomeActive {
}
- (void)appDidBecomeActive {
  //NSLog(@"app did become active.");
}
- (void)appWillBecomeInactive {
}
- (void)appDidBecomeInactive {
  //NSLog(@"app did become inactive.");
}

- (BOOL)isActive {
  return (mainWindow != nil);
}

- (void)addWindow:(GTKWindow *)_window {
  [windows addObject:_window];
  [_window setApplication:self];
}

- (void)removeWindow:(GTKWindow *)_window {
  [_window setApplication:nil];
  [windows removeObject:_window];
}

- (void)checkForClosedWindows {
  int  cnt, winCount = [windows count];
  BOOL hasOpenWindows = NO;

  for (cnt = 0; (cnt < winCount) && (hasOpenWindows == NO); cnt++) {
    GTKWindow *win = [windows objectAtIndex:cnt];
    if ([win isVisible])
      hasOpenWindows = YES;
  }
  
  if (hasOpenWindows == NO) {
    if ([delegate respondsToSelector:
                    @selector(applicationShouldTerminateAfterLastWindowClosed:)]) {
      if (![delegate applicationShouldTerminateAfterLastWindowClosed:self])
        return;
    }

    [self terminate:self];
  }
}

- (GTKWindow *)keyWindow {
  return keyWindow ? keyWindow : [self mainWindow];
}
- (GTKWindow *)mainWindow {
  return mainWindow;
}

- (void)_setKeyWindow:(GTKWindow *)_window {
  if (_window == nil) keyWindow = [self mainWindow];
  else keyWindow = _window;
}
- (void)_setMainWindow:(GTKWindow *)_window {
  if (_window == nil) {
    if (mainWindow != nil) {
      [self appWillBecomeInactive];
      mainWindow = nil;
      keyWindow  = nil;
      [self appDidBecomeInactive];
    }
  }
  else {
    BOOL wasActive = [self isActive];
    
    if (!wasActive)
      [self appWillBecomeActive];
    
    keyWindow  = _window;
    mainWindow = _window;

    if (!wasActive)
      [self appDidBecomeActive];
  }
}

// timers

- (void)addTimer:(GTKTimer *)_timer {
  if (timers == nil) timers = [[NSMutableArray alloc] initWithCapacity:16];
  [timers addObject:_timer];
  [_timer _setupForApplication:self];
}
- (void)removeTimer:(GTKTimer *)_timer {
  [_timer _removeFromApplication:self];
  [timers removeObject:_timer];
}

// ********** tooltips *********

- (GTKToolTips *)defaultToolTips {
  return defaultToolTips;
}
- (void)enableToolTips:(id)sender {
  [[self defaultToolTips] enable:sender];
}
- (void)disableToolTips:(id)sender {
  [[self defaultToolTips] disable:sender];
}

@end
