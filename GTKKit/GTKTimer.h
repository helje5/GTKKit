/*
   GTKTimer.h

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

// $Id: GTKTimer.h,v 1.1 1998/07/09 06:07:44 helge Exp $

#include <gtk/gtk.h>
#import <Foundation/NSObject.h>
#include <Foundation/NSTimer.h>	// jet
@class GTKApplication;

@interface GTKTimer : NSObject
{
  NSTimeInterval interval; // interval in seconds
  id   target;
  SEL  action;
  BOOL isValid;
  BOOL isRepeating;
  id   userInfo;

  GTKApplication *app;
  gint           tag;
}

+ (GTKTimer *)timerWithTimeInterval:(NSTimeInterval)_seconds
  target:(id)_target selector:(SEL)_selector
  userInfo:(id)_userInfo
  repeats:(BOOL)_repeats;

- (void)performAction;
- (void)invalidate;

// accessors

- (NSTimeInterval)interval;
- (id)target;
- (SEL)action;
- (BOOL)isValid;

// private

- (GTKApplication *)application;
- (gint)tag;
- (BOOL)_handleTimeout;
- (void)_setupForApplication:(GTKApplication *)_app;
- (void)_removeFromApplication:(GTKApplication *)_app;

@end
