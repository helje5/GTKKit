/*
   GTKList.h

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

// $Id: GTKList.h,v 1.3 1998/08/05 13:42:01 helge Exp $

#include <gtk/gtklist.h>
#import <GTKKit/GTKContainer.h>
#import <GTKKit/GTKControl.h>

@interface GTKList : GTKContainer < GTKControl >
{
  id  target;
  SEL action;
}

+ (id)list;

// accessors

/*
  selection_mode          selection contents
  ------------------------------------------------------
  
  GTK_SELECTION_SINGLE    selection is either empty or one element
  
  GTK_SELECTION_BROWSE    selection is NULL if the list
                          contains no widgets, otherwise
                          it contains a GList* pointer
                          for one GList structure.
  GTK_SELECTION_MULTIPLE  selection is NULL if no listitems
                          are selected or a a GList* pointer
                          for the first selected item. that
                          in turn points to a GList structure
                          for the second selected item and so
                          on
*/

- (void)setSelectionMode:(GtkSelectionMode)_mode;
- (GtkSelectionMode)selectionMode;

// modifiying

// selection

- (void)selectItemAtIndex:(gint)_idx;
- (void)deselectItemAtIndex:(gint)_idx;
- (NSArray *)selectedItems;

// private

- (GtkList *)gtkList;
+ (guint)typeIdentifier;

#if GTKKIT_GTK_11
- (guint)hTimer;
- (guint)vTimer;
#else
- (guint32)listTimer;
#endif

- (GList *)children;

#if !(GTKKIT_GTK_11)
- (guint16)selectionStartIndex;
- (guint16)selectionEndIndex;
#endif
- (GList *)selection;

@end
