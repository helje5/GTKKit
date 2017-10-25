// $Id: GTKContainer.h,v 1.6 1998/08/05 13:42:00 helge Exp $

/*
   GTKContainer.h

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

#include <gtk/gtkcontainer.h>
#import <GTKKit/GTKWidget.h>

@interface GTKContainer : GTKWidget
{
  NSMutableArray *subWidgets;
}

// hierachy

- (void)_primaryAddSubWidget:(GTKWidget *)_widget;
- (void)_primaryRemoveSubWidget:(GTKWidget *)_widget;
- (void)_primaryInsertSubWidget:(GTKWidget *)_widget atIndex:(int)_idx;
- (void)addSubWidget:(GTKWidget *)_widget;
- (void)removeSubWidget:(GTKWidget *)_widget;

- (void)addSubWidgets:(GTKWidget *)_first,...;
- (void)addSubWidgets:(GTKWidget *)_first arguments:(va_list)_other;

- (NSArray *)subWidgets;

// showing

- (void)showAll;
- (void)hideAll;

// properties

- (void)setBorderWidth:(gint)_width;
- (gint)borderWidth;

#if !GTKKIT_GTK_11
- (void)setResizingEnabled:(BOOL)_flag;
- (BOOL)isResizingEnabled;
#endif

#if GTKKIT_GTK_11
- (void)setResizeMode:(GtkResizeMode)_mode;
- (void)checkResize;
#else
// replaced by setResizeMode
- (void)blockResizing;
- (void)unblockResizing;
#endif

// private

- (GtkContainer *)gtkContainer;
+ (guint)typeIdentifier;

@end

@interface GTKContainer(ContainerEvents)

- (void)containerWidgetAdded:(GTKSignalEvent *)_event;
- (void)containerWidgetRemoved:(GTKSignalEvent *)_event;
- (void)containerNeedsResize:(GTKSignalEvent *)_event;

@end
