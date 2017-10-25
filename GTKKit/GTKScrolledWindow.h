/*
   GTKScrolledWindow.h

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

// $Id: GTKScrolledWindow.h,v 1.1 1998/07/09 06:07:39 helge Exp $

#include <gtk/gtkscrolledwindow.h>
#import <GTKKit/GTKContainer.h>

@class GTKAdjustment;

@interface GTKScrolledWindow : GTKContainer
{
}

+ (id)scrolledWindow;
+ (id)scrolledWindowWithAdjustment:(GTKAdjustment *)_h:(GTKAdjustment *)_v;
+ (id)scrolledWindowWithContent:(GTKWidget *)_content;
- (id)initWithAdjustment:(GTKAdjustment *)_horiz:(GTKAdjustment *)_vert;

// accessors

/*
  The policy may be one of GTK_POLICY AUTOMATIC, or GTK_POLICY_ALWAYS.
  GTK_POLICY_AUTOMATIC will automatically decide whether you need
  scrollbars, wheras GTK_POLICY_ALWAYS will always leave the scrollbars
  there.  
*/

- (void)setHorizScrollbarPolicy:(GtkPolicyType)_policy;
- (guint8)horizScrollbarPolicy;
- (void)setVertScrollbarPolicy:(GtkPolicyType)_policy;
- (guint8)vertScrollbarPolicy;

// adjustments

- (GTKAdjustment *)horizontalAdjustment;
- (GTKAdjustment *)verticalAdjustment;

// private

- (GtkScrolledWindow *)gtkScrolledWindow;
+ (guint)typeIdentifier;

@end
