/*
   GTKToggleButton.m

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

// $Id: GTKToggleButton.m,v 1.11 1998/07/14 12:23:54 helge Exp $

#import "common.h"
#import "GTKToggleButton.h"

@implementation GTKToggleButton

+ (id)buttonWithTitle:(NSString *)_label state:(BOOL)_state {
  GTKToggleButton *button = [[self alloc] initWithTitle:_label];
  [button setState:_state];
  return AUTORELEASE(button);
}

- (id)initWithGtkObject:(GtkObject *)_obj {
  if ((self = [super initWithGtkObject:_obj])) {
    sendMode = GTKButtonSendMode_SendOnChange;
    state    = NO;
  }
  return self;
}

- (id)init {
  return [self initWithGtkObject:(GtkObject *)gtk_toggle_button_new()];
}

// init widget

static GTKSignalMapEntry sigs[] = {
  { @"toggled",  @selector(buttonToggled:) },
  { NULL, NULL }
};

- (void)loadSignalMappings {
  static BOOL loadedMappings = NO;

  if (!loadedMappings) {
    loadedMappings = YES;
    [super loadSignalMappings];
    [self loadSignalMappingsFromTable:sigs];
  }
}

- (void)loadGtkObject {
  [super loadGtkObject];
  [self observeSignalsWithNames:@"toggled", nil];
}

// signals

static BOOL oldState = NO;

- (void)buttonToggled:(GTKSignalEvent *)_event {
  state = ((GtkToggleButton *)gtkObject)->active ? YES : NO;
}

- (void)buttonPressed:(GTKSignalEvent *)_event {
  oldState = state;
}

- (void)buttonReleased:(GTKSignalEvent *)_event {
  state = ((GtkToggleButton *)gtkObject)->active ? YES : NO;

  if (state != oldState) {
    if (sendMode == GTKButtonSendMode_SendOnChange)
      [self sendAction:action to:target];
  }
  else {
    [super buttonReleased:_event];
  }
}

// state

- (void)setState:(BOOL)_state {
  gtk_toggle_button_set_state((GtkToggleButton *)gtkObject, _state ? TRUE : FALSE);
  state = ((GtkToggleButton *)gtkObject)->active ? YES : NO;
}
- (BOOL)state {
  state = ((GtkToggleButton *)gtkObject)->active ? YES : NO;
  return state;
}

// values

- (void)setStringValue:(NSString *)_string {
  _string = [_string uppercaseString];
  if ([_string isEqualToString:@"YES"])
    [self setState:YES];
  else if ([_string isEqualToString:@"1"])
    [self setState:YES];
  else if ([_string isEqualToString:@"TRUE"])
    [self setState:YES];
  else
    [self setState:NO];
}

- (NSString *)stringValue {
  return [self boolValue] ? @"YES" : @"NO";
}

- (void)setBoolValue:(BOOL)_flag {
  [self setState:_flag];
}
- (BOOL)boolValue {
  return [self state];
}

- (void)setIntValue:(int)_value {
  [self setState:_value ? YES : NO];
}
- (int)intValue {
  return [self state];
}

// private

- (GtkToggleButton *)gtkToggleButton {
  return (GtkToggleButton *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_toggle_button_get_type();
}

@end
