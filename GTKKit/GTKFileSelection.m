/*
   GTKFileSelection.m

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

// $Id: GTKFileSelection.m,v 1.5 1998/08/05 19:43:54 helge Exp $

#import "common.h"
#import "GTKFileSelection.h"

@implementation GTKFileSelection

static void fileSelOk(GtkWidget *button, GTKFileSelection *fs) {
  [fs ok:fs];
}
static void fileSelCancel(GtkWidget *button, GTKFileSelection *fs) {
  [fs cancel:fs];
}
static void fileSelHelp(GtkWidget *button, GTKFileSelection *fs) {
  [fs help:fs];
}

+ fileSelectionWithTitle:(NSString *)_title {
  return AUTORELEASE([[self alloc] initWithTitle:_title]);
}

- (id)initWithGtkObject:(GtkObject *)_obj {
  if ((self = [super initWithGtkObject:_obj])) {
    [self setReleasedWhenClosed:NO];
  }
  return self;
}

- (id)init {
  return [self initWithTitle:@"File Selection"];
}
- (id)initWithTitle:(NSString *)_title {
  GtkObject *obj = (GtkObject *)gtk_file_selection_new([_title cString]);
  return [self initWithGtkObject:obj];
}

- (void)dealloc {
  [self setTarget:nil];
  [super dealloc];
}

// late initialization

- (void)runLateInitialization {
  if (!didRunLateInit) {
    [super runLateInitialization];
    
    gtk_signal_connect((GtkObject *)[self gtkOkButton],
                       "clicked",
                       (GtkSignalFunc)fileSelOk,
                       (gpointer)self);
    gtk_signal_connect((GtkObject *)[self gtkCancelButton],
                       "clicked",
                       (GtkSignalFunc)fileSelCancel,
                       (gpointer)self);
    gtk_signal_connect((GtkObject *)[self gtkHelpButton],
                       "clicked",
                       (GtkSignalFunc)fileSelHelp,
                       (gpointer)self);
  }
}

// properties

- (void)setFilename:(NSString *)_filename {
  gtk_file_selection_set_filename((GtkFileSelection *)gtkObject,
                                  [_filename cString]);
}
- (NSString *)filename {
  gchar *fname = gtk_file_selection_get_filename((GtkFileSelection *)gtkObject);
  return [NSString stringWithCString:fname];
}

// control

- (void)setTarget:(id)_target {
  ASSIGN(target, _target);
}
- (id)target {
  return target;
}

- (void)setOkAction:(SEL)_action {
  okAction = _action;
}
- (SEL)okAction {
  return okAction;
}
- (void)setCancelAction:(SEL)_action {
  cancelAction = _action;
}
- (SEL)cancelAction {
  return cancelAction;
}
- (void)setHelpAction:(SEL)_action {
  helpAction = _action;
}
- (SEL)helpAction {
  return helpAction;
}

- (BOOL)sendAction:(SEL)_action to:(id)_target {
  return [GTKApp sendAction:_action to:_target from:self];
}

// actions

- (void)ok:(id)_sender {
  if (![self sendAction:okAction to:target]) {
    NSLog(@"%@: ok", self);
  }
}
- (void)cancel:(id)_sender {
  if (![self sendAction:cancelAction to:target]) {
    NSLog(@"%@: cancel", self);
  }
}
- (void)help:(id)_sender {
  if (![self sendAction:helpAction to:target]) {
    NSLog(@"%@: help", self);
  }
}

- (void)showFileOperationButtons:(id)_sender {
  gtk_file_selection_show_fileop_buttons((GtkFileSelection *)gtkObject);
}
- (void)hideFileOperationButtons:(id)_sender {
  gtk_file_selection_hide_fileop_buttons((GtkFileSelection *)gtkObject);
}

// private

- (GtkFileSelection *)gtkFileSelection {
  return (GtkFileSelection *)gtkObject;
}

- (GtkButton *)gtkOkButton {
  return (GtkButton *)((GtkFileSelection *)gtkObject)->ok_button;
}
- (GtkButton *)gtkCancelButton {
  return (GtkButton *)((GtkFileSelection *)gtkObject)->cancel_button;
}
- (GtkButton *)gtkHelpButton {
  return (GtkButton *)((GtkFileSelection *)gtkObject)->help_button;
}

+ (guint)typeIdentifier {
  return gtk_file_selection_get_type();
}

@end
