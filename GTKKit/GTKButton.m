/*
   GTKButton.m

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

// $Id: GTKButton.m,v 1.17 1998/08/09 14:29:41 helge Exp $

#import "common.h"
#import "GTKButton.h"
#import "GTKLabel.h"

@implementation GTKButton

+ (id)button {
  return AUTORELEASE([[self alloc] init]);
}
+ (id)buttonWithTitle:(NSString *)_title {
  return AUTORELEASE([[self alloc] initWithTitle:_title]);
}

- (id)initWithGtkObject:(GtkObject *)_obj {
  if ((self = [super initWithGtkObject:_obj])) {
    sendMode = GTKButtonSendMode_SendOnRelease;
  }
  return self;
}

- (id)init {
  return [self initWithGtkObject:(GtkObject *)gtk_button_new()];
}
- (id)initWithTitle:(NSString *)_title {
  if ((self = [self init])) {
    [self addSubWidget:[GTKLabel labelWithTitle:_title]];
  }
  return self;
}

- (void)dealloc {
  RELEASE(target); target = nil;
  [super dealloc];
}

// init widget

static GTKSignalMapEntry sigs[] = {
  { @"enter",    @selector(buttonEntered:) },
  { @"leave",    @selector(buttonLeft:) },
  { @"clicked",  @selector(buttonClicked:) },
  { @"pressed",  @selector(buttonPressed:) },
  { @"released", @selector(buttonReleased:) },
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
  [self observeSignalsWithNames:@"clicked", @"pressed", @"released", nil];
}

// accessors

- (void)setTitle:(NSString *)_title {
  NSEnumerator *sw = [subWidgets objectEnumerator];
  GTKWidget    *w  = nil;

  while ((w = [sw nextObject])) {
    if ([w isKindOfClass:[GTKLabel class]]) {
      [(GTKLabel *)w setTitle:_title];
      break;
    }
  }
}

- (NSString *)title {
  NSEnumerator *sw = [subWidgets objectEnumerator];
  GTKWidget    *w  = nil;

  while ((w = [sw nextObject])) {
    if ([w isKindOfClass:[GTKLabel class]])
      return [(GTKLabel *)w title];
  }
  return nil;
}

// signals

- (void)buttonPressed:(GTKSignalEvent *)_event {
  if (self->sendMode == GTKButtonSendMode_SendOnPress)
    [self sendAction:self->action to:self->target];
}
- (void)buttonReleased:(GTKSignalEvent *)_event {
  if (self->sendMode == GTKButtonSendMode_SendOnRelease)
    [self sendAction:self->action to:self->target];
}

- (void)buttonClicked:(GTKSignalEvent *)_event {
  if (self->sendMode == GTKButtonSendMode_SendOnClick)
    [self sendAction:self->action to:self->target];
}

// control

- (void)setTarget:(id)_target {
  ASSIGN(target, _target);
}
- (id)target {
  return self->target;
}

- (void)setAction:(SEL)_action {
  self->action = _action;
}
- (SEL)action {
  return self->action;
}

- (BOOL)sendAction:(SEL)_action to:(id)_target {
  return [GTKApp sendAction:_action to:_target from:self];
}

// values

- (NSString *)stringValue {
  return @"0";
}
- (id)objectValue {
  return [NSNumber numberWithBool:NO];
}
- (int)intValue {
  return 0;
}
- (float)floatValue {
  return 0.0;
}
- (double)doubleValue {
  return 0.0;
}

// private

- (GtkButton *)gtkButton {
  return (GtkButton *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_button_get_type();
}

// description

- (NSString *)actionDescription {
  NSMutableString *str = [[NSMutableString alloc] init];

  [str appendString:@"<"];
  if (self->target) {
    [str appendFormat:@"%s[0x%08X]",
           [[self->target class] name], (unsigned)self->target];
  }
  if (self->action) {
    if (self->target) [str appendString:@"@"];
    [str appendString:NSStringFromSelector(self->action)];
  }
  [str appendString:@">"];

  return [str autorelease];
}

- (NSString *)description {
  return [NSString stringWithFormat:
                     @"<%s[0x%08X] %@ action=%@ border=%i>",
                     [[self class] name], gtkObject,
                     [self frameDescription],
                     [self actionDescription],
                     [self borderWidth]
                   ];
}

@end
