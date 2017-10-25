/*
   GTKColorSelection.m

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

// $Id: GTKColorSelection.m,v 1.9 1998/08/16 13:59:08 helge Exp $

#import "common.h"
#import "GTKColorSelection.h"

@implementation GTKColorSelection

+ colorSelection {
  return [[[self alloc] init] autorelease];
}
+ colorSelectionDialog:(NSString *)aTitle; {
  return [[[self alloc] initDialog:aTitle] autorelease];
}

- (id)init {
  GtkObject *obj = (GtkObject *)gtk_color_selection_new();
  return [self initWithGtkObject:obj];
}

- (id)initDialog:(NSString *)aTitle; {
  GtkObject *obj = (GtkObject *)gtk_color_selection_dialog_new([aTitle cString]);
  return [self initWithGtkObject:obj];
}

// init widget

- (void)loadGtkObject {
  [super loadGtkObject];
  [self observeSignalsWithNames:@"color_changed", nil];
}

- (void)setColor:(gdouble*)_color {
  gtk_color_selection_set_color((GtkColorSelection *)gtkObject, _color);
}

- (gdouble*)color {
  gtk_color_selection_get_color((GtkColorSelection *)gtkObject, color);
  return color;
}

- (void)setGdkColor:(GdkColor*)_color {
  gtk_color_selection_get_color((GtkColorSelection *)gtkObject, color); 
  _color->red   = (guint16)(color[0]*65535.0);
  _color->green = (guint16)(color[1]*65535.0);
  _color->blue  = (guint16)(color[2]*65535.0);
}


- (void)takeColorFrom:(id)_sender {
  [self setColor:[_sender color]];
}


// signals

- (void)colorDidChange:(GTKSignalEvent *)_event {
  // NSLog(@"color changed");
  [self sendAction:action to:target];
}

- (SEL)handlerForEvent:(GTKSignalEvent *)_event {
  if ([[_event signalName] isEqualToString:@"color_changed"])
    return @selector(colorDidChange:);
  else
    return [super handlerForEvent:_event];
}

- (void)handleEvent:(GTKSignalEvent *)_event {
  SEL handler = [self handlerForEvent:_event];
  
  if (handler)
    [self performSelector:handler withObject:_event];
  else
    [super handleEvent:_event];
}

- (void)dealloc {
  [self setTarget:nil];
  [super dealloc];
}

// control

- (void)setTarget:(id)_target {
  ASSIGN(target, _target);
}
- (id)target {
  return target;
}

- (void)setAction:(SEL)_action {
  action = _action;
}
- (SEL)action {
  return action;
}

- (BOOL)sendAction:(SEL)_action to:(id)_target {
  return [GTKApp sendAction:_action to:_target from:self];
}
 
// private

- (GtkColorSelection *)gtkColorSelection {
  return (GtkColorSelection *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_color_selection_get_type();
}

@end
