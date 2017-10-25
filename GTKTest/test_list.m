/*
   test_list.m
  
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
// $Id: test_list.m,v 1.2 1998/07/14 16:36:59 helge Exp $

#import <Foundation/Foundation.h>
#import <GTKKit/GTKKit.h>
#import "test_make_window.h"

@interface ListController : NSObject
{
@public
  GTKList *list;
}

- (void)addItem:(id)_sender;
- (void)removeItem:(id)_sender;
- (void)clearItemsOneToFive:(id)_sender;

@end

id makeListWindow(NSString *_title, id _ctrl) {
  static NSString *list_items[] =
  {
    @"hello",
    @"world",
    @"blah",
    @"foo",
    @"bar",
    @"argh",
    @"spencer",
    @"is a",
    @"wussy",
    @"programmer",
  };
  static int nlist_items = sizeof (list_items) / sizeof (list_items[0]);
  
  GTKWindow *window = makeTestWindowWithTitle(_title);
  GTKBox    *rootBox;
  ListController *ctrl = [[ListController alloc] init];

  rootBox = [GTKBox verticalBoxWithSpacing:0 sameSize:NO];
  [window setContentWidget:rootBox];

  {
    GTKBox *vbox = [GTKBox verticalBoxWithSpacing:10 sameSize:NO];
    {
      GTKScrolledWindow *scroller;
      GTKButton         *button;

      scroller = [GTKScrolledWindow scrolledWindow];
      [scroller setHorizScrollbarPolicy:GTK_POLICY_AUTOMATIC];
      [scroller setVertScrollbarPolicy:GTK_POLICY_AUTOMATIC];
      {
        GTKList *list;

        list = [GTKList list];
        [list setSelectionMode:GTK_SELECTION_BROWSE];
        {
          int cnt;

          for (cnt = 0; cnt < nlist_items; cnt++) {
            GTKListItem *item = [GTKListItem listItemWithTitle:list_items[cnt]];
            [list addSubWidget:item];
          }
        }
        ctrl->list = list;
        [scroller addSubWidget:list];
      }
      [vbox addSubWidget:scroller];

      button = [GTKButton buttonWithTitle:@"add"];
      [button setTarget:ctrl];
      [button setAction:@selector(addItem:)];
      [button setLayout:[GTKBoxLayoutInfo layoutWithNoExpand]];
      [vbox addSubWidget:button];
      
      button = [GTKButton buttonWithTitle:@"clear items 3 - 5"];
      [button setTarget:ctrl];
      [button setAction:@selector(clearItemsOneToFive:)];
      [button setLayout:[GTKBoxLayoutInfo layoutWithNoExpand]];
      [vbox addSubWidget:button];
      
      button = [GTKButton buttonWithTitle:@"remove"];
      [button setTarget:ctrl];
      [button setAction:@selector(removeItem:)];
      [button setLayout:[GTKBoxLayoutInfo layoutWithNoExpand]];
      [vbox addSubWidget:button];
    }
    [vbox setBorderWidth:10];
    [rootBox addSubWidget:vbox];
  }

  RELEASE(ctrl); ctrl = nil;
  [rootBox addSubWidget:[GTKSeparator horizontalSeparator]];
  [rootBox addSubWidget:makeOrderOutButton(window)];
  return window;
}

@implementation ListController

- (void)addItem:(id)_sender {
  static int i = 1;
  GTKListItem *item = nil;

  item = [GTKListItem listItemWithTitle:
                        [NSString stringWithFormat:@"added item %d", i++]];
  [item show];
  [list addSubWidget:item];
  [item show];
  [list show];
}

- (void)removeItem:(id)_sender {
}

- (void)clearItemsOneToFive:(id)_sender {
}

@end
