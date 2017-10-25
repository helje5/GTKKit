/*
   GTKProgressBar.m

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

// $Id: GTKProgressBar.m,v 1.3 1998/08/05 13:48:15 helge Exp $

#import "GTKKit.h"
#import "GTKProgressBar.h"

@implementation GTKProgressBar

+ (id)progressBar {
  return [[[self alloc] init] autorelease];
}
- init {
  return [self initWithGtkObject:(GtkObject *)gtk_progress_bar_new()];
}

// accessors

- (void)setFloatValue:(float)_value {
  gtk_progress_bar_update((GtkProgressBar *)gtkObject, _value);
}
- (float)floatValue {
#if GTKKIT_GTK_11
  GtkProgress *progress = (GtkProgress *)gtkObject;
  return gtk_progress_get_percentage_from_value(progress,
                                                gtk_progress_get_value(progress));
#else
  return ((GtkProgressBar *)gtkObject)->percentage;
#endif
}

- (void)setDoubleValue:(double)_value {
  [self setFloatValue:_value];
}
- (double)doubleValue {
  return [self floatValue];
}
- (void)setStringValue:(NSString *)_value {
  [self setFloatValue:[_value floatValue]];
}
- (NSString *)stringValue {
  return [NSString stringWithFormat:@"%f", [self floatValue]];
}
- (void)setObjectValue:(id)_obj {
  [self setFloatValue:[_obj floatValue]];
}
- (id)objectValue {
  return [NSNumber numberWithFloat:[self floatValue]];
}

// private

- (GtkProgressBar *)gtkProgressBar {
  return (GtkProgressBar *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_progress_bar_get_type();
}

@end
