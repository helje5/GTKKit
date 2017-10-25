/*
   GTKPaned.h

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

// $Id: GTKPaned.h,v 1.2 1998/08/09 14:31:49 helge Exp $

#include <gtk/gtkpaned.h>
#include <gtk/gtkhpaned.h>
#include <gtk/gtkvpaned.h>
#import <GTKKit/GTKContainer.h>


@interface GTKPaned : GTKContainer
{
  GTKWidget *widget1;
  GTKWidget *widget2;
}

+ (id)horizontalPaned;
+ (id)verticalPaned;

// accessors

- (void)setHandleSize:(guint16)_size;
- (guint16)handleSize;
- (void)setGutterSize:(guint16)_size;
- (guint16)gutterSize;

- (void)setFirstWidget:(GTKWidget *)_widget;
- (GTKWidget *)firstWidget;

- (void)setSecondWidget:(GTKWidget *)_widget;
- (GTKWidget *)secondWidget;

// private

- (GtkPaned *)gtkPaned;
+ (guint)typeIdentifier;

@end

@interface GTKHorizPaned : GTKPaned
{
}

+ (id)horizontalPaned;
- (id)init;

// private

- (GtkHPaned *)gtkHPaned;
+ (guint)typeIdentifier;

@end

@interface GTKVertPaned : GTKPaned
{
}

+ (id)verticalPaned;
- (id)init;

// private

- (GtkVPaned *)gtkVPaned;
+ (guint)typeIdentifier;

@end
