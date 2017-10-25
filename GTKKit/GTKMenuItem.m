/*
   GTKMenuItem.m

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

// $Id: GTKMenuItem.m,v 1.6 1998/08/15 14:14:10 helge Exp $

#import "common.h"
#import "GTKMenuItem.h"
#import "GTKMenu.h"

@implementation GTKMenuItem

+ (id)menuItem {
  return [[[self alloc] init] autorelease];
}
+ (id)menuItemWithTitle:(NSString *)_title {
  return [[[self alloc] initWithTitle:_title] autorelease];
}

- (id)init {
  return [self initWithGtkObject:(GtkObject *)gtk_menu_item_new()];
}
- (id)initWithTitle:(NSString *)_title {
  GtkObject *obj = (GtkObject *)gtk_menu_item_new_with_label([_title cString]);
  return [self initWithGtkObject:obj];
}

#if !LIB_FOUNDATION_BOEHM_GC
- (void)dealloc {
  [self setTarget:nil];
  [self setSubMenu:nil];
  [super dealloc];
}
#endif

- (void)loadGtkObject {
  [super loadGtkObject];
  [self addSelfAsObserverForSignal:@"activate"];
}

// showing & hiding

- (void)showAll {
  [subMenu showAll];
  [super showAll];
}
- (void)hideAll {
  [super hideAll];
  [subMenu hideAll];
}

// properties

- (void)setShowsToggleIndicator:(BOOL)_flag {
  gtk_menu_item_configure((GtkMenuItem *)gtkObject,
                          _flag ? TRUE : FALSE,
                          [self doesShowSubMenuIndicator]);
}
- (BOOL)doesShowToggleIndicator {
  return ((GtkMenuItem *)gtkObject)->show_toggle_indicator;
}

- (void)setShowsSubMenuIndicator:(BOOL)_flag {
  gtk_menu_item_configure((GtkMenuItem *)gtkObject,
                          [self doesShowToggleIndicator],
                          _flag ? TRUE : FALSE);
}
- (BOOL)doesShowSubMenuIndicator {
  return ((GtkMenuItem *)gtkObject)->show_submenu_indicator;
}

- (BOOL)isRightJustified {
  return ((GtkMenuItem *)gtkObject)->right_justify;
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

// signals

- (void)menuWasActivated {
  [self sendAction:action to:target];
}

- (void)handleEvent:(GTKSignalEvent *)_event {
  if ([[_event signalName] isEqualToString:@"activate"])
    [self menuWasActivated];
  else
    [super handleEvent:_event];
}

// accelerator

- (void)setAcceleratorTitle:(NSString *)_title {
  // gtk_menu_item_accelerator_text((GtkMenuItem *)gtkObject, [_title cString]);
}

// subitems

- (void)setSubMenu:(GTKMenu *)_submenu {
  if (_submenu == self->subMenu)
    return;
  
  if (_submenu) {
    RELEASE(self->subMenu); self->subMenu = nil;
    
    if (gtkObject)
      gtk_menu_item_set_submenu((GtkMenuItem *)gtkObject, [_submenu gtkWidget]);
    self->subMenu = RETAIN(_submenu);
  }
  else {
    if (self->subMenu) {
      if (gtkObject)
        gtk_menu_item_remove_submenu((GtkMenuItem *)gtkObject);
      RELEASE(self->subMenu); self->subMenu = nil;
    }
  }
}
- (GTKWidget *)subMenu {
  return self->subMenu;
}

// actions

- (void)selectItem:(id)_sender {
  gtk_menu_item_select((GtkMenuItem *)gtkObject);
}
- (void)deselectItem:(id)_sender {
  gtk_menu_item_deselect((GtkMenuItem *)gtkObject);
}
- (void)activateItem:(id)_sender {
  gtk_menu_item_activate((GtkMenuItem *)gtkObject);
}
- (void)rightJustifyItem:(id)_sender {
  gtk_menu_item_right_justify((GtkMenuItem *)gtkObject);
}

// private

- (GtkMenuItem *)gtkMenuItem {
  return (GtkMenuItem *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_menu_item_get_type();
}

- (gint)menuItemTimer {
  return ((GtkMenuItem *)gtkObject)->timer;
}

@end
