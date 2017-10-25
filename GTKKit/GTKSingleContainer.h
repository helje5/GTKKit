/*
   GTKSingleContainer.h

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

// $Id: GTKSingleContainer.h,v 1.1 1998/07/09 06:07:40 helge Exp $

#include <gtk/gtkbin.h>
#import <GTKKit/GTKContainer.h>

// a gtk bin widget
// contains only one child widget

/*
  The bin widget is a container (see section The container widget) derived
  from the container widget. It is an abstract base class. That is, it is
  not possible to create an actual bin widget. It exists only to provide a
  base of functionality for other widgets. Specifically, the bin widget
  provides a base for several other widgets that contain only a single child.
  These widgets include alignments (see section The alignment widget),
  frames (see section The frame widget), items (see section The item widget),
  viewports (see section The viewport widget) and windows (see section
  The window widget)
*/

@interface GTKSingleContainer : GTKContainer
{
}

// accessors

- (void)setContentWidget:(GTKWidget *)_widget;
- (GTKWidget *)contentWidget;

// private

- (GtkBin *)gtkBin;
+ (guint)typeIdentifier;

@end
