// $Id: GTKWindow.m,v 1.10 1998/08/09 11:10:43 helge Exp $

/*
   GTKWindow.m

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

#import "common.h"
#import "GTKWindow.h"

NSString *NSWindowDidBecomeKeyNotification = @"NSWindowDidBecomeKeyNotification";
NSString *NSWindowDidResizeNotification    = @"NSWindowDidResizeNotification";
NSString *NSWindowWillCloseNotification    = @"NSWindowWillCloseNotification";
NSString *NSWindowDidCloseNotification     = @"NSWindowDidCloseNotification";

@implementation GTKWindow

- (id)initWithGtkObject:(GtkObject *)_obj {
  if ((self = [super initWithGtkObject:_obj])) {
    [self setReleasedWhenClosed:YES];
    isOpen    = NO;
    isVisible = NO;
  }
  return self;
}
- (id)init {
  return [self initWithGtkObject:(GtkObject *)gtk_window_new(GTK_WINDOW_TOPLEVEL)];
}

- (void)dealloc {
  [delegate release]; delegate = nil;
  [super dealloc];
  app           = nil;
  defaultWidget = nil;
}

// init widget

static GTKSignalMapEntry sigs[] = {
  { @"destroy",      @selector(windowGotDestroy:) },
  { @"delete_event", @selector(windowDeleteEvent:) },
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
  [self observeSignalsWithNames:@"destroy", @"delete_event", nil];
}

// accessors

- (void)setTitle:(NSString *)_title {
  NSAssert(gtkObject, @"no gtk object available");
  
  gtk_window_set_title((GtkWindow *)gtkObject, [_title cString]);
}
- (NSString *)title {
  if (((GtkWindow *)gtkObject)->title)
    return [NSString stringWithCString:((GtkWindow *)gtkObject)->title];
  else
    return nil;
}

- (void)setApplication:(GTKApplication *)_app {
  app = _app;
}
- (GTKApplication *)application {
  return app;
}

- (void)setDelegate:(id)_delegate {
  ASSIGN(delegate, _delegate);
}
- (id)delegate {
  return delegate;
}

- (void)setReleasedWhenClosed:(BOOL)_flag {
  releaseWhenClosed = _flag;
}
- (BOOL)isReleasedWhenClosed {
  return releaseWhenClosed;
}

- (void)setAllowGrowing:(BOOL)_flag {
  NSAssert(gtkObject, @"no gtk object available");

  gtk_window_set_policy((GtkWindow *)gtkObject,
                        ((GtkWindow *)gtkObject)->allow_shrink,
                        _flag ? TRUE : FALSE,
                        ((GtkWindow *)gtkObject)->auto_shrink);
}
- (BOOL)isGrowingAllowed {
  return ((GtkWindow *)gtkObject)->allow_grow;
}

- (void)setAllowShrinking:(BOOL)_flag {
  NSAssert(gtkObject, @"no gtk object available");
  
  gtk_window_set_policy((GtkWindow *)gtkObject,
                        _flag ? TRUE : FALSE,
                        ((GtkWindow *)gtkObject)->allow_grow,
                        ((GtkWindow *)gtkObject)->auto_shrink);
}
- (BOOL)isShrinkingAllowed {
  return ((GtkWindow *)gtkObject)->allow_shrink;
}

- (void)setDoesAutoshrink:(BOOL)_flag {
  NSAssert(gtkObject, @"no gtk object available");
  
  gtk_window_set_policy((GtkWindow *)gtkObject,
                        ((GtkWindow *)gtkObject)->allow_shrink,
                        ((GtkWindow *)gtkObject)->allow_grow,
                        _flag ? TRUE : FALSE);
}
- (BOOL)doesAutoshrink {
  return ((GtkWindow *)gtkObject)->auto_shrink;
}

// hierachy

- (GTKWindow *)window {
  return self;
}

// showing

- (void)show {
  NSLog(@"WARNING: [GTKWindow show] called, use orderFront: !");
}
- (void)showAll {
  NSLog(@"WARNING: [GTKWindow showAll] called, use orderFront: !");
}

- (void)hide {
  NSLog(@"WARNING: [GTKWindow hide] called, use orderOut: !");
}
- (void)hideAll {
  NSLog(@"WARNING: [GTKWindow hideAll] called, use orderOut: !");
}

- (BOOL)isVisible {
  return isVisible;
}

- (void)orderFront:(id)sender {
  NSAssert(gtkObject, @"no gtk object available");
  
  if (![self isVisible]) {
    [subWidgets makeObjectsPerform:@selector(showAll)];
    gtk_widget_show((GtkWidget *)gtkObject);
  }
  else {
    gtk_widget_show((GtkWidget *)gtkObject);
  }
  isOpen = YES;
}

- (void)orderOut:(id)sender {
  if ([self isVisible]) {
    gtk_widget_hide((GtkWidget *)gtkObject);
    isVisible = NO;
    [subWidgets makeObjectsPerform:@selector(hideAll)];
    [[self application] checkForClosedWindows];
  }
}

- (void)show:(id)_sender {
  [self orderFront:_sender];
}
- (void)hide:(id)_sender {
  [self orderOut:_sender];
}

// signals

- (BOOL)performKeyEquivalent:(id)_event {
  return NO;
}

- (void)widgetDidShow:(GTKSignalEvent *)_event {
  //  NSLog(@"%@: did show", self);
  isVisible = YES;
}
- (void)widgetDidHide:(GTKSignalEvent *)_event {
  //  NSLog(@"%@: did hide", self);
  isVisible = NO;
}

/*
- (void)widgetDidMap:(GTKSignalEvent *)_event {
  NSLog(@"%@: did map", self);
}
- (void)widgetDidUnmap:(GTKSignalEvent *)_event {
  NSLog(@"%@: did unmap", self);
}
- (void)widgetDidRealize:(GTKSignalEvent *)_event {
  NSLog(@"%@: did realize", self);
}
- (void)widgetDidUnrealize:(GTKSignalEvent *)_event {
  NSLog(@"%@: did unrealize", self);
}
*/

- (void)widgetGotFocus:(GTKSignalEvent *)_event {
  [GTKApp _setMainWindow:self];
}
- (void)widgetLostFocus:(GTKSignalEvent *)_event {
  [GTKApp _setMainWindow:nil];
}

- (void)windowGotDestroy:(GTKSignalEvent *)_event {
  [self performClose:self];
}
- (void)windowDeleteEvent:(GTKSignalEvent *)_event {
  [self performClose:self];
}

// open state

- (void)performClose:(id)sender {
  if (isOpen) {
    BOOL doClose = YES;

    if ([delegate respondsToSelector:@selector(windowShouldClose:)])
      doClose = [delegate windowShouldClose:self];

    NSLog(@"performClose: doClose=%s", doClose ? "yes" : "no");
  
    if (doClose) [self close];
  }
}

- (void)close {
  if (isOpen) {
    //    NSLog(@"close: will close window %@", self);

    [self selfPostNotification:NSWindowWillCloseNotification
          delegateSelector:@selector(windowWillClose:)];

    [self orderOut:self];
    if (releaseWhenClosed) [self release];
    isOpen = NO;

    [self selfPostNotification:NSWindowDidCloseNotification
          delegateSelector:@selector(windowDidClose:)];

    NSLog(@"close: did close window %@", self);

    [[self application] checkForClosedWindows];
  }
}

- (BOOL)isOpen {
  return isOpen;
}

// default widget

- (void)setDefaultWidget:(GTKWidget *)_widget {
  NSAssert(gtkObject, @"no gtk object available");
  
  if (_widget) {
    GTK_WIDGET_SET_FLAGS([_widget gtkObject], GTK_CAN_DEFAULT);
    gtk_window_set_default((GtkWindow *)gtkObject, [_widget gtkWidget]);
  }
  else {
    gtk_window_set_default((GtkWindow *)gtkObject, NULL);
  }

  defaultWidget = _widget;
}
- (GTKWidget *)defaultWidget {
  return defaultWidget;
}

// private

- (GtkWindow *)gtkWindow {
  return (GtkWindow *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_window_get_type();
}

- (void)setWindowManagerClass:(NSString *)_class name:(NSString *)_name {
  gtk_window_set_wmclass((GtkWindow *)gtkObject,
                         (char *)[_name cString],
                         (char *)[_class cString]);
}
- (NSString *)windowManagerClassName {
  return [NSString stringWithCString:((GtkWindow *)gtkObject)->wmclass_name];
}
- (NSString *)windowManagerClass {
  return [NSString stringWithCString:((GtkWindow *)gtkObject)->wmclass_class];
}

- (void)setFocusWidget:(GTKWidget *)_widget {
  NSAssert(gtkObject, @"no gtk object available");

  gtk_window_set_focus((GtkWindow *)gtkObject, [_widget gtkWidget]);
}

- (gint)activateFocus:(id)_sender {
  NSAssert(gtkObject, @"no gtk object available");

  return gtk_window_activate_focus((GtkWindow *)gtkObject);
}
- (gint)activateDefault:(id)_sender {
  NSAssert(gtkObject, @"no gtk object available");

  return gtk_window_activate_default((GtkWindow *)gtkObject);
}

// description

- (NSString *)description {
  return [NSString stringWithFormat:@"<%s[0x%08X] frame=%@ title=%@ isOpen=%s>",
                     [[self class] name], gtkObject, [self frameDescription],
                     [self title], [self isOpen] ? "YES" : "NO"];
}

@end
