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

// $Id: GTKKit.h,v 1.17 1998/08/16 20:21:02 helge Exp $

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

#import <GTKKit/GTKAccelLabel.h>
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

#import <GTKKit/GTKObject+Bean.h>
#import <GTKKit/NSObject+TakeValues.h>

#define LINK_GTKKit \
  static void __link_GTKKit(void) {\
    ;\
    [GTKAccelLabel      self]; \
    [GTKAdjustment      self]; \
    [GTKAlignment       self]; \
    [GTKBox             self]; \
    [GTKBoxLayoutInfo   self]; \
    [GTKButton          self]; \
    [GTKCheckButton     self]; \
    [GTKContainer       self]; \
    [GTKData            self]; \
    [GTKDialog          self]; \
    [GTKEditable        self]; \
    [GTKEntry           self]; \
    [GTKFileSelection   self]; \
    [GTKFixed           self]; \
    [GTKFixedLayoutInfo self]; \
    [GTKFrame           self]; \
    [GTKHorizBox        self]; \
    [GTKHorizPaned      self]; \
    [GTKHorizScale      self]; \
    [GTKHorizScrollbar  self]; \
    [GTKHorizSeparator  self]; \
    [GTKItem            self]; \
    [GTKLabel           self]; \
    [GTKList            self]; \
    [GTKListItem        self]; \
    [GTKMenu            self]; \
    [GTKMenuBar         self]; \
    [GTKMenuItem        self]; \
    [GTKMenuShell       self]; \
    [GTKMenuWindow      self]; \
    [GTKMiscWidget      self]; \
    [GTKNotebook        self]; \
    [GTKObject          self]; \
    [GTKPaned           self]; \
    [GTKPixmap          self]; \
    [GTKProgressBar     self]; \
    [GTKRadioButton     self]; \
    [GTKRange           self]; \
    [GTKScale           self]; \
    [GTKScrollbar       self]; \
    [GTKScrolledWindow  self]; \
    [GTKSeparator       self]; \
    [GTKSignalEvent     self]; \
    [GTKSingleContainer self]; \
    [GTKSpinButton      self]; \
    [GTKTable           self]; \
    [GTKTableLayoutInfo self]; \
    [GTKTableList       self]; \
    [GTKText            self]; \
    [GTKToggleButton    self]; \
    [GTKToolTips        self]; \
    [GTKToolbar         self]; \
    [GTKTree            self]; \
    [GTKTreeItem        self]; \
    [GTKVertBox         self]; \
    [GTKVertPaned       self]; \
    [GTKVertScale       self]; \
    [GTKVertScrollbar   self]; \
    [GTKVertSeparator   self]; \
    [GTKWidget          self]; \
    [GTKWindow          self]; \
    \
    __link_NSObjectTakeValues(); \
    __link_GTKObject_Bean();     \
    __link_GTKKit(); \
  }
