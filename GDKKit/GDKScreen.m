/*
   GDKScreen.m

   Copyright (C) 1998 Helge Hess.
   All rights reserved.

   Author: Helge Hess <helge@mdlink.de>

   This file is part of GDKKit.

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

// $Id: GDKScreen.m,v 1.2 1998/08/06 00:59:40 helge Exp $

#import "common.h"
#import "GDKScreen.h"

@implementation GDKScreen

static GDKScreen *systemScreen = nil;

+ (GDKScreen *)screen {
  if (systemScreen == nil) {
    systemScreen = [[GDKScreen alloc] init];
  }
  return systemScreen;
}

// accessors

- (GDKCoord)width {
  return gdk_screen_width();
}
- (GDKCoord)height {
  return gdk_screen_height();
}

- (GDKCoord)widthInMillimeters {
  return gdk_screen_width_mm();
}
- (GDKCoord)heightInMillimeters {
  return gdk_screen_height_mm();
}

- (void)setUseSharedMemory:(BOOL)_flag {
  gdk_set_use_xshm(_flag);
}
- (BOOL)doesUseSharedMemory {
  return gdk_get_use_xshm();
}

- (NSString *)displayName {
  return [NSString stringWithCString:gdk_get_display()];
}

// operations

- (void)beep {
  gdk_beep();
}
- (void)flush {
  gdk_flush();
}

- (void)disableKeyRepeat {
  gdk_key_repeat_disable();
}
- (void)restoreKeyRepeat {
  gdk_key_repeat_restore();
}

// events

- (gint)numberOfPendingEvents {
  return gdk_events_pending();
}

- (GdkEvent *)getEvent {
  return gdk_event_get();
}
- (void)putEvent:(GdkEvent *)_event {
  gdk_event_put(_event);
}

- (void)setShowEvents:(BOOL)_flag {
  gdk_set_show_events(_flag);
}
- (BOOL)doesShowEvents {
  return gdk_get_show_events();
}

// timer

- (NSTimeInterval)timeSinceInitialization {
  return (((NSTimeInterval)gdk_time_get()) / 1000.0);
}

- (void)setTimerInterval:(NSTimeInterval)_interval {
  gdk_timer_set((guint32)(_interval * 1000.0));
}

- (NSTimeInterval)currentTimerInterval {
  return (((NSTimeInterval)gdk_timer_get()) / 1000.0);
}

- (void)enableTimer {
  gdk_timer_enable();
}
- (void)disableTimer {
  gdk_timer_disable();
}

// description

- (NSString *)description {
  return [NSString stringWithFormat:
                     @"<Screen: size=[%ix%i] display=%@ "
                     @"showsEvents=%s usesSharedMemory=%s>",
                     [self width], [self height],
                     [self displayName],
                     [self doesShowEvents] ? "YES" : "NO",
                     [self doesUseSharedMemory] ? "YES" : "NO"
                   ];
}

@end
