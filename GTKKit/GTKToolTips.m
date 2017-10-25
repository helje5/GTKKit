/*
   GTKToolTips.m

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

// $Id: GTKToolTips.m,v 1.4 1998/07/10 12:22:26 helge Exp $

#import "common.h"
#import "GTKToolTips.h"
#import "GTKWidget.h"

@implementation GTKToolTips

+ (id)tooltips {
  return AUTORELEASE([[self alloc] init]);
}
- (id)init {
  return [self initWithGtkObject:(GtkObject *)gtk_tooltips_new()];
}

// properties

- (void)setDelay:(NSTimeInterval)_delay {
  gtk_tooltips_set_delay((GtkTooltips *)gtkObject, (gint)(_delay * 1000.0));
}
- (NSTimeInterval)delay {
  return ((NSTimeInterval)((GtkTooltips *)gtkObject)->delay) / 1000.0;
}

- (void)setEnabled:(BOOL)_flag {
  if (_flag) gtk_tooltips_enable((GtkTooltips *)gtkObject);
  else gtk_tooltips_disable((GtkTooltips *)gtkObject);
}
- (BOOL)isEnabled {
  return ((GtkTooltips *)gtkObject)->enabled;
}

// setting tips

- (void)setToolTip:(NSString *)_value ofWidget:(GTKWidget *)_widget {
  gtk_tooltips_set_tip((GtkTooltips *)gtkObject,
                       [_widget gtkWidget],
                       [_value cString],
                       NULL);
}

// actions

- (void)enable:(id)sender {
  [self setEnabled:YES];
}
- (void)disable:(id)sender {
  [self setEnabled:NO];
}

// private

- (GtkTooltips *)gtkTooltips {
  return ((GtkTooltips *)gtkObject);
}
+ (guint)typeIdentifier {
  return gtk_tooltips_get_type();
}

- (gint)toolTipTimer {
  return ((GtkTooltips *)gtkObject)->timer_tag;
}

@end
