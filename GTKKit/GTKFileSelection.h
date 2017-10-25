/*
   GTKFileSelection.h

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

// $Id: GTKFileSelection.h,v 1.2 1998/08/05 19:43:54 helge Exp $

#include <gtk/gtkfilesel.h>
#import <GTKKit/GTKWindow.h>

/*
  The file selection widget is a quick and simple way to display a
  File dialog box. It comes complete with Ok, Cancel, and Help buttons,
  a great way to cut down on programming time. 
*/


@interface GTKFileSelection : GTKWindow
{
  id  target;
  SEL okAction;
  SEL cancelAction;
  SEL helpAction;
}

+ (id)fileSelectionWithTitle:(NSString *)_title;
- (id)initWithTitle:(NSString *)_title;

// properties

- (void)setFilename:(NSString *)_filename;
- (NSString *)filename;

// actions

- (void)setTarget:(id)_target;
- (id)target;
- (void)setOkAction:(SEL)_action;
- (SEL)okAction;
- (void)setCancelAction:(SEL)_action;
- (SEL)cancelAction;
- (void)setHelpAction:(SEL)_action;
- (SEL)helpAction;

- (BOOL)sendAction:(SEL)_action to:(id)_target;

- (void)ok:(id)_sender;
- (void)cancel:(id)_sender;
- (void)help:(id)_sender;

- (void)showFileOperationButtons:(id)_sender;
- (void)hideFileOperationButtons:(id)_sender;

// private

- (GtkButton *)gtkOkButton;
- (GtkButton *)gtkCancelButton;
- (GtkButton *)gtkHelpButton;

- (GtkFileSelection *)gtkFileSelection;
+ (guint)typeIdentifier;

@end
