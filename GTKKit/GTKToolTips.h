/*
   GTKToolTips.h

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

// $Id: GTKToolTips.h,v 1.1 1998/07/09 06:07:45 helge Exp $

#include <gtk/gtktooltips.h>
#import <GTKKit/GTKData.h>

@class NSString;
@class GTKWidget;

@interface GTKToolTips : GTKData
{
}

+ (id)tooltips;
- (id)init;

// properties

- (void)setDelay:(NSTimeInterval)_delay;
- (NSTimeInterval)delay;
- (void)setEnabled:(BOOL)_flag;
- (BOOL)isEnabled;

// setting tips

- (void)setToolTip:(NSString *)_value ofWidget:(GTKWidget *)_widget;

// actions

- (void)enable:(id)sender;
- (void)disable:(id)sender;

// private

- (GtkTooltips *)gtkTooltips;
+ (guint)typeIdentifier;

- (gint)toolTipTimer;

@end
