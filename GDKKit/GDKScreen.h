/*
   GDKScreen.h

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

// $Id: GDKScreen.h,v 1.2 1998/08/06 00:59:39 helge Exp $

#import <gdk/gdktypes.h>
#import <Foundation/NSObject.h>
#import <GDKKit/GDKTypes.h>

/*
  This represents the X11 screen. However currently there is always only one screen.
*/

@interface GDKScreen : NSObject
{
}

+ (GDKScreen *)screen;

// properties

- (GDKCoord)width;
- (GDKCoord)height;

- (void)setUseSharedMemory:(BOOL)_flag;
- (BOOL)doesUseSharedMemory;

- (NSString *)displayName;

// operations

- (void)beep;
- (void)flush;

- (void)disableKeyRepeat;
- (void)restoreKeyRepeat;

// events

- (gint)numberOfPendingEvents;
- (GdkEvent *)getEvent;
- (void)putEvent:(GdkEvent *)_event;

/*
 * setShowEvents:
 *
 *   Turns on/off the showing of events.
 *
 * Arguments:
 *   "_flag" is a boolean describing whether or not to show
 *   the events gdk receives.
 *
 * Side effects:
 *   When "_flag" is TRUE, calls to "gdk_event_get"
 *   will output debugging informatin regarding the event
 *   received to stdout.
 */
- (void)setShowEvents:(BOOL)_flag;
- (BOOL)doesShowEvents;

// timer

/*
 * timeSinceInitialization
 *
 *   Get the number of seconds since the library was
 *   initialized.
 *
 * Results:
 *   The time since the library was initialized is returned.
 *   This time value is accurate to milliseconds even though
 *   a more accurate time down to the microsecond could be
 *   returned.
 */
- (NSTimeInterval)timeSinceInitialization;

/*
 * currentTimerInterval
 *
 *   Returns the current timer.
 *
 * Arguments:
 *
 * Results:
 *   Returns the current timer interval. This interval is
 *   in units of seconds.
 */
- (NSTimeInterval)currentTimerInterval;

- (void)setTimerInterval:(NSTimeInterval)_interval;
- (void)enableTimer;
- (void)disableTimer;

@end
