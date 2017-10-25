/*
   GTKWidget.m

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

// $Id: GTKWidget.m,v 1.15 1998/08/07 08:19:05 helge Exp $

#import "common.h"
#import "GTKWidget.h"
#import "GTKBox.h"
#import "GTKLayoutInfo.h"
#import "GTKContainer.h"
#import "GTKFixed.h"
#import "GTKToolTips.h"

@implementation GTKWidget

static GTKSignalMapEntry sigs[] = {
  { @"show",            @selector(widgetDidShow:) },
  { @"hide",            @selector(widgetDidHide:) },
  { @"map",             @selector(widgetDidMap:)  },
  { @"unmap",           @selector(widgetDidUnmap:) },
  { @"realize",         @selector(widgetDidRealize:) },
  { @"unrealize",       @selector(widgetDidUnrealize:) },
  { @"focus_in_event",  @selector(widgetGotFocus:) },
  { @"focus_out_event", @selector(widgetLostFocus:) },
  { @"size_request",    @selector(widgetGotSizeRequest:) },
  { @"size_allocate",   @selector(widgetGotSizeAllocate:) },
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

// init

- (id)initWithGtkObject:(GtkObject *)_object {
  if ((self = [super initWithGtkObject:_object])) {
    layout = RETAIN([GTKBoxLayoutInfo defaultLayout]);
  }
  return self;
}

- (void)dealloc {
  RELEASE(layout);       layout = nil;
  RELEASE(window);       window = nil;
  RELEASE(parentWindow); parentWindow = nil;
  [super dealloc];
}

- (void)loadGtkObject {
  [super loadGtkObject];

  [self observeSignalsWithNames:
          @"show", @"hide", @"map", @"unmap", @"realize", @"unrealize",
          @"focus_in_event", @"focus_out_event",
          @"size_request", @"size_allocate",
          nil];
}

// late init

- (void)runLateInitialization {
  if (!didRunLateInit)
    didRunLateInit = YES;
}
- (void)storeLateAttributes {
}

// showing

- (void)show {
  // NSLog(@"showing widget %@", self);
  gtk_widget_show((GtkWidget *)gtkObject);
}
- (void)showAll {
  [self show];
}
- (void)hide {
  [self storeLateAttributes];
  gtk_widget_hide((GtkWidget *)gtkObject);
  didRunLateInit = NO;
}
- (void)hideAll {
  [self hide];
}

- (void)show:(id)_sender {
  if (!GTK_WIDGET_VISIBLE(gtkObject)) [self show];
}
- (void)hide:(id)_sender {
  if (GTK_WIDGET_VISIBLE(gtkObject)) [self hide];
}

// layout info

- (void)setLayout:(GTKLayoutInfo *)_layout {
  ASSIGN(layout, _layout);
}
- (GTKLayoutInfo *)layout {
  return layout;
}

// tag

- (void)setTag:(int)_tag {
  tag = _tag;
}
- (int)tag {
  return tag;
}

// widget hierachy

- (void)setSuperWidget:(GTKContainer *)_super {
  superWidget = _super;
}
- (GTKContainer *)superWidget {
  return superWidget;
}

- (void)removeFromSuperWidget {
  if ([superWidget respondsToSelector:@selector(removeSubWidget:)])
    [(GTKContainer *)superWidget removeSubWidget:self];
}

- (GTKWindow *)window {
  return [[self superWidget] window];
}

// properties

- (void)setWidgetName:(NSString *)_name {
  gtk_widget_set_name((GtkWidget *)gtkObject, [_name cString]);
}
- (NSString *)widgetName {
  if (gtkObject == NULL) return nil;
  return [NSString stringWithCString:((GtkWidget *)gtkObject)->name];
}

- (void)setSize:(gint)_width:(gint)_height {
  gtk_widget_set_usize((GtkWidget *)gtkObject, _width, _height);
}
- (void)setPosition:(gint)_x:(gint)_y {
  if ([superWidget isKindOfClass:[GTKFixed class]])
    gtk_fixed_move([(GTKFixed *)superWidget gtkFixed], (GtkWidget *)gtkObject,
                   _x, _y);
  else
    gtk_widget_set_uposition((GtkWidget *)gtkObject, _x, _y);
}

- (int)desiredWidth {
  if (gtkObject == NULL) return 0;
  return ((GtkWidget *)gtkObject)->requisition.width;
}
- (int)desiredHeight {
  if (gtkObject == NULL) return 0;
  return ((GtkWidget *)gtkObject)->requisition.height;
}

- (int)leftEdge {
  if (gtkObject == NULL) return 0;
  return ((GtkWidget *)gtkObject)->allocation.x;
}
- (int)topEdge {
  if (gtkObject == NULL) return 0;
  return ((GtkWidget *)gtkObject)->allocation.y;
}
- (int)width {
  if (gtkObject == NULL) return 0;
  return ((GtkWidget *)gtkObject)->allocation.width;
}
- (int)height {
  if (gtkObject == NULL) return 0;
  return ((GtkWidget *)gtkObject)->allocation.height;
}

// events

- (void)widgetDidRealize:(GTKSignalEvent *)_event {
  [self runLateInitialization];
}

- (SEL)handlerForEvent:(GTKSignalEvent *)_event {
  SEL  sel   = NULL;
  gint sigid = [_event signal];

  sel = [self selectorForSignal:sigid];
  if (sel) return sel;
  return [super handlerForEvent:_event];
}

- (void)handleEvent:(GTKSignalEvent *)_event {
  SEL handler = [self handlerForEvent:_event];

  if (handler)
    [self performSelector:handler withObject:_event];
  else
    [super handleEvent:_event];
}

// drag'n'drop

static gchar **acceptListFromArray(NSArray *_array) {
  guint typeCount    = [_array count];
  gchar **acceptList = g_malloc(typeCount);
  guint cnt;

  for (cnt = 0; cnt < typeCount; cnt++) {
    NSString *mimeEntry = [[_array objectAtIndex:cnt] stringValue];
    char     *entry     = g_malloc([mimeEntry cStringLength] + 1);
    
    [mimeEntry getCString:entry];
    acceptList[cnt] = entry;
  }
  return acceptList;
}

- (void)enableDraggingOfTypes:(NSArray *)_types {
  gtk_widget_dnd_drag_set((GtkWidget *)gtkObject, TRUE,
                          acceptListFromArray(_types),
                          [_types count]);
}
- (void)disableDraggingOfTypes:(NSArray *)_types {
  gtk_widget_dnd_drag_set((GtkWidget *)gtkObject, FALSE,
                          acceptListFromArray(_types),
                          [_types count]);
}

- (void)enableDroppingOfTypes:(NSArray *)_types isDestructive:(BOOL)_flag {
  gtk_widget_dnd_drop_set((GtkWidget *)gtkObject, TRUE,
                          acceptListFromArray(_types),
                          [_types count],
                          _flag);
}
- (void)disableDroppingOfTypes:(NSArray *)_types {
  gtk_widget_dnd_drop_set((GtkWidget *)gtkObject, FALSE,
                          acceptListFromArray(_types),
                          [_types count],
                          FALSE);
}

- (void)setDraggingData:(NSData *)_data forEvent:(GdkEvent *)_event {
  gtk_widget_dnd_data_set((GtkWidget *)gtkObject, _event,
                          (gpointer)[_data bytes], [_data length]);
}

// state

- (BOOL)isVisible {
  return GTK_WIDGET_VISIBLE(gtkObject);
}
- (BOOL)isMapped {
  return GTK_WIDGET_MAPPED(gtkObject);
}
- (BOOL)isRealized {
  return GTK_WIDGET_REALIZED(gtkObject);
}
- (BOOL)isSensitive {
  return GTK_WIDGET_SENSITIVE(gtkObject);
}
- (BOOL)isParentSensitive {
  return GTK_WIDGET_PARENT_SENSITIVE(gtkObject);
}
- (BOOL)hasNoWindow {
  return GTK_WIDGET_NO_WINDOW(gtkObject);
}
- (BOOL)hasFocus {
  return GTK_WIDGET_HAS_FOCUS(gtkObject);
}
- (BOOL)canHaveFocus {
  return GTK_WIDGET_CAN_FOCUS(gtkObject);
}
- (BOOL)hasGrab {
  return GTK_WIDGET_HAS_GRAB(gtkObject);
}

- (BOOL)isDrawable {
  return GTK_WIDGET_DRAWABLE(gtkObject);
}

// notifications

- (void)selfPostNotification:(NSString *)_name delegateSelector:(SEL)_sel {
  NSNotification *notification = nil;

  notification = [NSNotification notificationWithName:_name object:self];

  // if it has an delegate, post notification to delegate first
  if ([self respondsToSelector:@selector(delegate)]) {
    id delegate = [(id)self delegate];

    if ([delegate respondsToSelector:_sel])
      [delegate performSelector:_sel withObject:notification];
  }

  // now post to defaultCenter
  [[NSNotificationCenter defaultCenter] postNotification:notification];
}

// application tool tips

- (void)setToolTip:(NSString *)_tip {
  [[GTKApp defaultToolTips] setToolTip:_tip ofWidget:self];
}

// private

- (GtkWidget *)gtkWidget {
  return (GtkWidget *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_widget_get_type();
}

// description

- (NSString *)frameDescription {
  int le = [self leftEdge];
  int te = [self topEdge];
  int w  = [self width];
  int h  = [self height];
  
  return [NSString stringWithFormat:@"[%i,%i %ix%i]", le, te, w, h];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"<%s[0x%08X] %@>",
                     [[self class] name], gtkObject, [self frameDescription]];
}

@end
