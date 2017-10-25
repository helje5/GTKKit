/*
   GTKButton.h

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

// $Id: GTKButton.h,v 1.10 1998/08/09 14:29:40 helge Exp $

#include <gtk/gtkbutton.h>
#import <GTKKit/GTKContainer.h>
#import <GTKKit/GTKControl.h>

@class NSString;

/*
  You can control when the button sends its action using the sendMode. The
  normal buttons sends it's action when it is pressed by default, toggle
  buttons, when their state changes (the user might click on them several
  times, but the state of the button won't change).
  
  Signal mappings:

    clicked   => buttonClicked:
    pressed   => buttonPressed:
    released  => buttonReleased:
    enter     => buttonEntered:
    leave     => buttonLeft:
 */

typedef enum {
  GTKButtonSendMode_SendOnRelease = 0, // default
  GTKButtonSendMode_SendOnPress,
  GTKButtonSendMode_SendOnClick,
  GTKButtonSendMode_SendOnChange // for toggle buttons
} GTKButtonSendMode;

@interface GTKButton : GTKContainer < GTKControl >
{
  id   target;
  SEL  action;
  GTKButtonSendMode sendMode;
}

+ (id)buttonWithTitle:(NSString *)_label;
- (id)initWithTitle:(NSString *)_label;

// events

- (void)buttonClicked:(GTKSignalEvent *)_event;
- (void)buttonPressed:(GTKSignalEvent *)_event;
- (void)buttonReleased:(GTKSignalEvent *)_event;

// accessors

// the title methods work on the first label subwidget
- (void)setTitle:(NSString *)_title;
- (NSString *)title;

// values

- (NSString *)stringValue;
- (id)objectValue;
- (int)intValue;
- (float)floatValue;
- (double)doubleValue;

// private

- (GtkButton *)gtkButton;
+ (guint)typeIdentifier;

@end
