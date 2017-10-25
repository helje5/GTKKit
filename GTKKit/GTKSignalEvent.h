/*
   GTKSignal.h

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
// $Id: GTKSignalEvent.h,v 1.2 1998/07/11 19:10:05 helge Exp $

#include <gtk/gtksignal.h>
#import <Foundation/NSObject.h>

@class NSString, NSMutableDictionary;
@class GTKObject;

@interface GTKSignalEvent : NSObject
{
  NSString            *signalName;
  gint                signal;
  GTKObject           *receiver;
  NSMutableDictionary *args;
}

+ (id)eventWithSignalName:(NSString *)_name receiver:(GTKObject *)_receiver
  arguments:(GtkArg *)_args count:(guint)_argc;
- (id)initWithName:(NSString *)_name receiver:(GTKObject *)_receiver
  arguments:(GtkArg *)_args count:(guint)_argc;

// accessors

- (NSString *)signalName;
- (gint)signal;
- (GTKObject *)receiver;

@end
