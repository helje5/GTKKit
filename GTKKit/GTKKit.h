/*
   GTKKit.h

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

// $Id: GTKKit.h,v 1.15 1998/08/09 14:38:00 helge Exp $

// #import <Foundation/Foundation.h>

#define id _id
#include <gtk/gtk.h>
#undef id

#import <GTKKit/GTKSignalEvent.h>
#import <GTKKit/GTKUtilities.h>

#import <GTKKit/GTKApplication.h>
#import <GTKKit/GTKTimer.h>
#import <GTKKit/GTKControl.h>
#import <GTKKit/GTKTableDataSource.h>

#import <GTKKit/GTKAdjustment.h>
#import <GTKKit/GTKAlignment.h>
#import <GTKKit/GTKBox.h>
#import <GTKKit/GTKButton.h>
#import <GTKKit/GTKCheckButton.h>
#import <GTKKit/GTKContainer.h>
#import <GTKKit/GTKData.h>
#import <GTKKit/GTKDialog.h>
#import <GTKKit/GTKEditable.h>
#import <GTKKit/GTKEntry.h>
#import <GTKKit/GTKFileSelection.h>
#import <GTKKit/GTKFixed.h>
#import <GTKKit/GTKFrame.h>
#import <GTKKit/GTKItem.h>
#import <GTKKit/GTKLabel.h>
#import <GTKKit/GTKLayoutInfo.h>
#import <GTKKit/GTKList.h>
#import <GTKKit/GTKListItem.h>
#import <GTKKit/GTKMenu.h>
#import <GTKKit/GTKMenuBar.h>
#import <GTKKit/GTKMenuItem.h>
#import <GTKKit/GTKMenuShell.h>
#import <GTKKit/GTKMenuWindow.h>
#import <GTKKit/GTKMiscWidget.h>
#import <GTKKit/GTKNotebook.h>
#import <GTKKit/GTKObject.h>
#import <GTKKit/GTKPaned.h>
#import <GTKKit/GTKPixmap.h>
#import <GTKKit/GTKProgressBar.h>
#import <GTKKit/GTKRadioButton.h>
#import <GTKKit/GTKRange.h>
#import <GTKKit/GTKScale.h>
#import <GTKKit/GTKScrollbar.h>
#import <GTKKit/GTKScrolledWindow.h>
#import <GTKKit/GTKSeparator.h>
#import <GTKKit/GTKSingleContainer.h>
#import <GTKKit/GTKSpinButton.h>
#import <GTKKit/GTKTable.h>
#import <GTKKit/GTKTableList.h>
#import <GTKKit/GTKText.h>
#import <GTKKit/GTKToggleButton.h>
#import <GTKKit/GTKToolTips.h>
#import <GTKKit/GTKToolbar.h>
#import <GTKKit/GTKTree.h>
#import <GTKKit/GTKTreeItem.h>
#import <GTKKit/GTKWidget.h>
#import <GTKKit/GTKWindow.h>

#import <GTKKit/NSObject+TakeValues.h>

#define LINK_GTKKit \
  static void __link_GTKKit(void) {\
    ;\
    [GTKAdjustment      class]; \
    [GTKAlignment       class]; \
    [GTKBox             class]; \
    [GTKBoxLayoutInfo   class]; \
    [GTKButton          class]; \
    [GTKCheckButton     class]; \
    [GTKContainer       class]; \
    [GTKData            class]; \
    [GTKDialog          class]; \
    [GTKEditable        class]; \
    [GTKEntry           class]; \
    [GTKFileSelection   class]; \
    [GTKFixed           class]; \
    [GTKFixedLayoutInfo class]; \
    [GTKFrame           class]; \
    [GTKHorizBox        class]; \
    [GTKHorizPaned      class]; \
    [GTKHorizScale      class]; \
    [GTKHorizScrollbar  class]; \
    [GTKHorizSeparator  class]; \
    [GTKItem            class]; \
    [GTKLabel           class]; \
    [GTKList            class]; \
    [GTKListItem        class]; \
    [GTKMenu            class]; \
    [GTKMenuBar         class]; \
    [GTKMenuItem        class]; \
    [GTKMenuShell       class]; \
    [GTKMenuWindow      class]; \
    [GTKMiscWidget      class]; \
    [GTKNotebook        class]; \
    [GTKObject          class]; \
    [GTKPaned           class]; \
    [GTKPixmap          class]; \
    [GTKProgressBar     class]; \
    [GTKRadioButton     class]; \
    [GTKRange           class]; \
    [GTKScale           class]; \
    [GTKScrollbar       class]; \
    [GTKScrolledWindow  class]; \
    [GTKSeparator       class]; \
    [GTKSignalEvent     class]; \
    [GTKSingleContainer class]; \
    [GTKSpinButton      class]; \
    [GTKTable           class]; \
    [GTKTableLayoutInfo class]; \
    [GTKTableList       class]; \
    [GTKText            class]; \
    [GTKToggleButton    class]; \
    [GTKToolTips        class]; \
    [GTKToolbar         class]; \
    [GTKTree            class]; \
    [GTKTreeItem        class]; \
    [GTKVertBox         class]; \
    [GTKVertPaned       class]; \
    [GTKVertScale       class]; \
    [GTKVertScrollbar   class]; \
    [GTKVertSeparator   class]; \
    [GTKWidget          class]; \
    [GTKWindow          class]; \
    \
    __link_NSObjectTakeValues(); \
    __link_GTKKit(); \
  }
