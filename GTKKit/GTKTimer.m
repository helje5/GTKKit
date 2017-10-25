/*
   GTKTimer.m

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

// $Id: GTKTimer.m,v 1.2 1998/07/10 12:18:31 helge Exp $

#import "common.h"
#import "GTKTimer.h"

@implementation GTKTimer

static gint timeout_callback(gpointer data) {
  return [(GTKTimer *)data _handleTimeout] ? TRUE : FALSE;
}

- initWithInterval:(NSTimeInterval)_interval
  target:(id)_target action:(SEL)_sel {
  [super init];
  app         = nil;
  interval    = _interval;
  target      = [_target retain];
  action      = _sel;
  isValid     = YES;
  isRepeating = YES;
  return self;
}

+ (GTKTimer *)timerWithTimeInterval:(NSTimeInterval)_seconds
  target:(id)_target selector:(SEL)_selector
  userInfo:(id)_userInfo
  repeats:(BOOL)_repeats {

  GTKTimer *timer = [[self alloc] initWithInterval:_seconds
                                  target:_target action:_selector];
  timer->isRepeating = _repeats;
  timer->userInfo    = [_userInfo retain];
  
  [GTKApp addTimer:timer];
  [timer release];
  return timer;
}

+ timerWithInterval:(gint)_interval target:(id)_target action:(SEL)_sel {
  return [[[self alloc]
                 initWithInterval:_interval target:_target action:_sel]
                 autorelease];
}

- (void)dealloc {
  if (app) [app removeTimer:self];
  [target   release]; target = nil;
  [userInfo release]; userInfo = nil;
  isValid = NO;
  isRepeating = NO;
  [super dealloc];
}

- (void)performAction {
  if (!isValid) {
    if (app) [app removeTimer:self];
  }
  else [target performSelector:action withObject:self];
}
- (void)invalidate {
  isValid = NO;
}

- (NSTimeInterval)interval {
  return interval;
}
- (id)target {
  return target;
}
- (SEL)action {
  return action;
}
- (BOOL)isValid {
  return isValid;
}

// private

- (GTKApplication *)application {
  return app;
}
- (gint)tag {
  return tag;
}

- (BOOL)_handleTimeout {
  // return YES to continue timeouts, NO to stop all
  [self performAction];
  
  if (isRepeating) {
    return YES;
  }
  else {
    [self invalidate];
    [GTKApp removeTimer:self];
    return NO;
  }
}

- (void)_setupForApplication:(GTKApplication *)_app {
  if (app) [app removeTimer:self];
  app = _app;
  tag = gtk_timeout_add((gint)(interval * 1000.0),
                        timeout_callback, (gpointer)self);
}
- (void)_removeFromApplication:(GTKApplication *)_app {
  gtk_timeout_remove(tag);
  app = nil;
  tag = 0;
}

@end
