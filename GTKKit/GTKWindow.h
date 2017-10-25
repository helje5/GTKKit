// $Id: GTKWindow.h,v 1.1 1998/07/09 06:07:50 helge Exp $

/*
   GTKWindow.h

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

#include <gtk/gtkwindow.h>
#import <GTKKit/GTKSingleContainer.h>

@class NSNotification;
@class GTKApplication;

extern NSString *NSWindowDidBecomeKeyNotification;
extern NSString *NSWindowDidResizeNotification;
extern NSString *NSWindowWillCloseNotification;
extern NSString *NSWindowDidCloseNotification;

@interface GTKWindow : GTKSingleContainer
{
  GTKApplication *app;           // not retained
  GTKWidget      *defaultWidget; // not retained
  id             delegate;
  BOOL           releaseWhenClosed;
  BOOL           isOpen;
  BOOL           isVisible;
}

- (id)init;

// accessors

- (void)setTitle:(NSString *)_title;
- (NSString *)title;

- (GTKApplication *)application;

- (void)setDelegate:(id)_obj;
- (id)delegate;
- (void)setReleasedWhenClosed:(BOOL)_flag;
- (BOOL)isReleasedWhenClosed;

- (void)setAllowGrowing:(BOOL)_flag;
- (BOOL)isGrowingAllowed;
- (void)setAllowShrinking:(BOOL)_flag;
- (BOOL)isShrinkingAllowed;
- (void)setDoesAutoshrink:(BOOL)_flag;
- (BOOL)doesAutoshrink;

// showing

- (void)show;
- (void)showAll;
- (void)hide;
- (void)hideAll;

- (BOOL)isVisible;
- (void)orderFront:(id)sender;
- (void)orderOut:(id)sender;

// signals

- (BOOL)performKeyEquivalent:(id)_event;

// open state

- (void)performClose:(id)sender;
- (void)close;
- (BOOL)isOpen;

// default widget

- (void)setDefaultWidget:(GTKWidget *)_widget;
- (GTKWidget *)defaultWidget;

// private

- (GtkWindow *)gtkWindow;
+ (guint)typeIdentifier;

- (void)setApplication:(GTKApplication *)_app;

- (void)setWindowManagerClass:(NSString *)_class name:(NSString *)_name;
- (NSString *)windowManagerClassName;
- (NSString *)windowManagerClass;

- (void)setFocusWidget:(GTKWidget *)_widget;
- (void)setDefaultWidget:(GTKWidget *)_widget;
- (gint)activateFocus:(id)_sender;
- (gint)activateDefault:(id)_sender;

@end

@interface NSObject(GTKWindowDelegate)

- (void)windowDidBecomeKey:(NSNotification *)_notification;
- (void)windowDidResize:(NSNotification *)_notification;
- (BOOL)windowShouldClose:(id)sender;
- (void)windowWillClose:(NSNotification *)_notification;
- (void)windowDidClose:(NSNotification *)_notification;

@end
