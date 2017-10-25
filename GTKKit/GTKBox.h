/*
   GTKBox.h

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

// $Id: GTKBox.h,v 1.7 1998/08/09 14:29:40 helge Exp $

#include <gtk/gtkbox.h>
#include <gtk/gtkvbox.h>
#include <gtk/gtkhbox.h>
#import <GTKKit/GTKContainer.h>
#import <GTKKit/GTKLayoutInfo.h>

/*
  The expand argument controls whether the widgets are laid out in the box to
  fill in all the extra space in the box so the box is expanded to fill the
  area alloted to it (YES). Or the box is shrunk to just fit the widgets (NO).
  Setting expand to NO will allow you to do right and left justifying of your
  widgets. Otherwise, they will all expand to fit in the box, and the same
  effect could be achieved by using only one of gtk_box_pack_start or pack_end
  functions. 

  The fill argument control whether the extra space is allocated to the objects
  themselves (YES), or as extra padding in the box around these objects (NO).
  It only has an effect if the expand argument is also YES.
*/
@interface GTKBoxLayoutInfo : GTKLayoutInfo
{
  BOOL expand;  // default: YES
  BOOL fill;    // default: YES
  int  padding; // default: 0
}

+ (id)defaultLayout;
+ (id)layoutWithNoExpand;
+ (id)layoutWithNoExpandAndNoFill;
+ (id)layoutWithPadding:(int)_padding doExpand:(BOOL)_expand doFill:(BOOL)_fill;
+ (id)layoutWithPadding:(int)_padding;

- (BOOL)expand;
- (BOOL)fill;
- (int)padding;

@end

@interface GTKBox : GTKContainer
{
}

/*
  The sameSize argument controls whether each object in the box has the
  same size (i.e. the same width in an hbox, or the same height in a vbox).
  If it is set, the expand argument to the pack methods is always turned on. 
*/

+ (id)horizontalBox;
+ (id)verticalBox;
+ (id)horizontalBoxWithSpacing:(int)_spacing sameSize:(BOOL)_flag;
+ (id)verticalBoxWithSpacing:(int)_spacing sameSize:(BOOL)_flag;
+ (id)horizontalBoxWithSpacing:(int)_spacing sameSize:(BOOL)_flag
  contents:(GTKWidget *)_first, ...;
+ (id)verticalBoxWithSpacing:(int)_spacing sameSize:(BOOL)_flag
  contents:(GTKWidget *)_first, ...;

// packing

- (void)addSubWidget:(GTKWidget *)_widget;

// accessors

- (void)setSpacing:(gint16)_spacing;
- (gint16)spacing;

- (void)setIsHomogeneous:(BOOL)_flag;
- (BOOL)isHomogeneous;

// private

- (GtkBox *)gtkBox;
+ (guint)typeIdentifier;

- (GList *)gtkChildren;

@end

@interface GTKVertBox : GTKBox
{
}

- (id)initWithSpacing:(int)_spacing isHomogeneous:(BOOL)_flag;

// private

- (GtkVBox *)gtkVBox;
+ (guint)typeIdentifier;

@end

@interface GTKHorizBox : GTKBox
{
}

- (id)initWithSpacing:(int)_spacing isHomogeneous:(BOOL)_flag;

// private

- (GtkHBox *)gtkHBox;
+ (guint)typeIdentifier;

@end
