/*
   test_tree.m
  
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
// $Id: test_tree.m,v 1.7 1998/07/14 11:54:16 helge Exp $

#import <Foundation/Foundation.h>
#import <GTKKit/GTKKit.h>
#import "test_make_window.h"

@interface TreeModeController : NSObject
{
  GtkSelectionMode selectMode;
@public
  GTKCheckButton   *drawLine;
  GTKCheckButton   *viewLineMode;
  GTKCheckButton   *withoutRoot;
  GTKEntry         *numItems;
  GTKEntry         *depth;
}

- (void)changeSelectMode:(id)_widget;

@end

static id makeSelectionModeFrame(id _ctrl) {
  GTKBox *box = nil;

  box = [GTKBox verticalBoxWithSpacing:0 sameSize:NO];
  [box setBorderWidth:5];
  {
    GTKRadioButton *r = nil;

    [box addSubWidget:(r = [GTKRadioButton buttonWithTitle:@"SINGLE"])];
    [r setTarget:_ctrl];
    [r setAction:@selector(changeSelectMode:)];
    [r setTag:GTK_SELECTION_SINGLE];
    [box addSubWidget:(r = [GTKRadioButton buttonWithTitle:@"BROWSE"   addedTo:r])];
    [r setTarget:_ctrl];
    [r setAction:@selector(changeSelectMode:)];
    [r setTag:GTK_SELECTION_BROWSE];
    [box addSubWidget:(r = [GTKRadioButton buttonWithTitle:@"MULTIPLE" addedTo:r])];
    [r setTarget:_ctrl];
    [r setTag:GTK_SELECTION_MULTIPLE];
    [r setAction:@selector(changeSelectMode:)];
  }
  return [GTKFrame frameWithTitle:@"Selection Mode" content:box];
}

static id makeOptionsModeFrame(TreeModeController *_ctrl) {
  GTKBox *box = nil;
  id b1, b2, b3;

  box = [GTKBox verticalBoxWithSpacing:0 sameSize:NO
                contents:
                  (b1=[GTKCheckButton buttonWithTitle:@"Draw line" state:YES]),
                  (b2=[GTKCheckButton buttonWithTitle:@"View Line mode" state:YES]),
                  (b3=[GTKCheckButton buttonWithTitle:@"Without Root item"]),
                  nil];
  [box setBorderWidth:5];
  //[box printWidgetHierachyWithIndent:1];

  _ctrl->drawLine     = b1;
  _ctrl->viewLineMode = b2;
  _ctrl->withoutRoot  = b3;

  return [GTKFrame frameWithTitle:@"Options" content:box];
}

static id makeSizeParametersFrame(TreeModeController *_ctrl) {
  GTKBox *box = nil;

  box = [GTKBox horizontalBoxWithSpacing:5 sameSize:NO];
  [box setBorderWidth:5];
  {
    GTKBox *box5  = nil;

    // number of item button
    box5 = [GTKBox horizontalBoxWithSpacing:5 sameSize:NO];
    {
      GTKLabel *label = nil;
      GTKSpinButton *entry = nil;

      label = [GTKLabel labelWithTitle:@"Number of Item"];
      [label setAlignment:0.0:0.5];
      [label setLayout:[GTKBoxLayoutInfo layoutWithNoExpand]];
      [box5 addSubWidget:label];

      entry = [GTKSpinButton spinButton];
      [entry setIntValue:3];
      [entry setDigitsAfterComma:0];
      [entry setMinValue:1];
      [entry setMaxValue:255];
      [entry setLayout:[GTKBoxLayoutInfo layoutWithNoExpand]];
      [box5 addSubWidget:entry];
      _ctrl->numItems = entry;
    }
    [box5 setLayout:[GTKBoxLayoutInfo layoutWithNoExpandAndNoFill]];
    [box addSubWidget:box5];

    // depth level button
    box5 = [GTKBox horizontalBoxWithSpacing:5 sameSize:NO];
    {
      GTKLabel      *label = nil;
      GTKSpinButton *entry = nil;

      label = [GTKLabel labelWithTitle:@"Depth Level"];
      [label setAlignment:0.0:0.5];
      [label setLayout:[GTKBoxLayoutInfo layoutWithNoExpand]];
      [box5 addSubWidget:label];

      entry = [GTKSpinButton spinButton];
      [entry setIntValue:3];
      [entry setDigitsAfterComma:0];
      [entry setMinValue:1];
      [entry setMaxValue:255];
      [entry setLayout:[GTKBoxLayoutInfo layoutWithNoExpand]];
      [box5 addSubWidget:entry];
      _ctrl->depth = entry;
    }
    [box5 setLayout:[GTKBoxLayoutInfo layoutWithNoExpandAndNoFill]];
    [box addSubWidget:box5];
  }
  
  return [GTKFrame frameWithTitle:@"Size Parameters" content:box];
}

id makeTreeModeWindow(NSString *_title, id _ctrl) {
  GTKWindow *window = makeTestWindowWithTitle(@"Tree Mode Selection Window");
  GTKBox    *rootBox;
  id        ctrl = [[TreeModeController alloc] init];

  rootBox = [GTKBox verticalBoxWithSpacing:0 sameSize:NO];
  [window setContentWidget:rootBox];

  // create upper box - selection box
  {
    GTKBox *box = nil;

    box = [GTKBox verticalBoxWithSpacing:5 sameSize:NO
                  contents:
                    [GTKBox horizontalBoxWithSpacing:5 sameSize:NO
                              contents:
                                makeSelectionModeFrame(ctrl),
                                makeOptionsModeFrame(ctrl),
                                nil],
                    makeSizeParametersFrame(ctrl),
                    nil];
    [box setBorderWidth:5];

    [rootBox addSubWidget:box];
  }

  [rootBox addSubWidget:[GTKSeparator horizontalSeparator]];
  {
    GTKBox    *hBox   = [GTKBox horizontalBoxWithSpacing:0 sameSize:NO];
    GTKButton *create = [GTKButton buttonWithTitle:@"Create Tree Sample"];
    GTKButton *close  = [GTKButton buttonWithTitle:@"Close"];
    
    [hBox setBorderWidth:5];
    [hBox addSubWidgets:create, close, nil];

    [create setTarget:ctrl];
    [create setAction:@selector(createTree:)];

    [close setTarget:window];
    [close setAction:@selector(orderOut:)];

    [rootBox addSubWidget:hBox];
    hBox   = nil;
    create = nil;
    close  = nil;
  }

  RELEASE(ctrl);
  
  return window;
}

id makeTreeSample(gint _selMode, BOOL _drawLine, BOOL _viewLine, BOOL _noRootItem,
                  int itemCount, int recursionLevel) {
  GTKWindow *window = makeTestWindowWithTitle(@"tree test");
  GTKBox    *rootBox;
  GTKTable  *table;

  rootBox = [GTKBox verticalBoxWithSpacing:0 sameSize:NO];
  [window setContentWidget:rootBox];

  [rootBox addSubWidget:[GTKSeparator horizontalSeparator]];
  [rootBox addSubWidget:makeOrderOutButton(window)];
  return window;
}

@implementation TreeModeController

- (id)init {
  if ((self = [super init])) {
    selectMode = GTK_SELECTION_SINGLE;
  }
  return self;
}

- (void)dealloc {
  [super dealloc];
}

- (void)changeSelectMode:(id)_widget {
  selectMode = [_widget tag];
  NSLog(@"%@: changed select mode to %i", [_widget title], selectMode);
}

- (void)createTree:(id)_sender {
  makeTreeSample(selectMode,
                 [drawLine     boolValue],
                 [viewLineMode boolValue],
                 [withoutRoot  boolValue],
                 [numItems     intValue],
                 [depth        intValue]);
}

@end
