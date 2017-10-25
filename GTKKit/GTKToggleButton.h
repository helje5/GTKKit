/*
   GTKToggleButton.h

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

// $Id: GTKToggleButton.h,v 1.5 1998/07/11 16:29:23 helge Exp $

#include <gtk/gtktogglebutton.h>
#import <GTKKit/GTKButton.h>

/*
  Toggle buttons are very similar to normal buttons, except they will always
  be in one of two states, alternated by a click. They may be depressed, and
  when you click again, they will pop back up. Click again, and they will pop
  back down.

  Toggle buttons are the basis for check buttons and radio buttons, as such,
  many of the calls used for toggle buttons are inherited by radio and check
  buttons. I will point these out when we come to them.

  Signal mappings:

    toggled => buttonToggled:
*/

@interface GTKToggleButton : GTKButton
{
  BOOL state;
}

+ (id)buttonWithTitle:(NSString *)_label state:(BOOL)_state;

// state

- (void)setState:(BOOL)_state;
- (BOOL)state;

// values

- (void)setBoolValue:(BOOL)_flag;
- (BOOL)boolValue;
- (void)setIntValue:(int)_value;
- (int)intValue;

// event

- (void)buttonToggled:(GTKSignalEvent *)_event;
- (void)buttonReleased:(GTKSignalEvent *)_event;

// private

- (GtkToggleButton *)gtkToggleButton;
+ (guint)typeIdentifier;

@end
