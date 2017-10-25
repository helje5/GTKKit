/*
   test_spinbutton.m
  
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
// $Id: test_spinbutton.m,v 1.3 1998/07/14 13:41:47 helge Exp $

#import <Foundation/Foundation.h>
#import <GTKKit/GTKKit.h>
#import "test_make_window.h"

@interface SpinController : NSObject
{
@public
  GTKSpinButton *valueSpin;
  GTKLabel      *valueLabel;
}

- (void)showAsInt:(id)_sender;
- (void)showAsFloat:(id)_sender;
- (void)updateDigits:(id)_digitsSpin;

@end

static id makeNotAcceleratedFrame(void) {
  GTKBox *box = nil;

  box = [GTKBox horizontalBoxWithSpacing:0 sameSize:NO];
  [box setBorderWidth:5];
  { // day, month, year spinners
    GTKBoxLayoutInfo *partLayout, *noExpandLayout;
    GTKBox        *part    = nil;
    GTKLabel      *label   = nil;
    GTKSpinButton *spinner = nil;

    partLayout     = [GTKBoxLayoutInfo layoutWithPadding:5 doExpand:YES doFill:YES];
    noExpandLayout = [GTKBoxLayoutInfo layoutWithNoExpand];

    {
      part    = [GTKBox verticalBoxWithSpacing:0 sameSize:NO];
      label   = [GTKLabel labelWithTitle:@"Day :" alignment:0:0.5];
      spinner = [GTKSpinButton spinButtonWithRange:1:31 wraps:YES];

      [part    setLayout:partLayout];
      [label   setLayout:noExpandLayout];
      [spinner setLayout:noExpandLayout];

      [part addSubWidgets:label, spinner, nil];
      [box addSubWidget:part];
      part = nil;
    }
    {
      part    = [GTKBox verticalBoxWithSpacing:0 sameSize:NO];
      label   = [GTKLabel labelWithTitle:@"Month :" alignment:0:0.5];
      spinner = [GTKSpinButton spinButtonWithRange:1:12 wraps:YES];
  
      [part    setLayout:partLayout];
      [label   setLayout:noExpandLayout];
      [spinner setLayout:noExpandLayout];

      [part addSubWidgets:label, spinner, nil];
      [box addSubWidget:part];
      part = nil;
    }
    {
      part    = [GTKBox verticalBoxWithSpacing:0 sameSize:NO];
      label   = [GTKLabel labelWithTitle:@"Year :" alignment:0:0.5];
      spinner = [GTKSpinButton spinButtonWithRange:0:2100 wraps:YES];
      [spinner setIntValue:1998];
      [spinner setSize:55:0];
      [spinner setPageSize:100.0];
  
      [part    setLayout:partLayout];
      [label   setLayout:noExpandLayout];
      [spinner setLayout:noExpandLayout];

      [part addSubWidgets:label, spinner, nil];
      [box addSubWidget:part];
      part = nil;
    }
  }
  return [GTKFrame frameWithTitle:@"Not accelerated" content:box];
}

static id makeAcceleratedFrame(SpinController *_ctrl) {
  GTKBox *box = nil;

  box = [GTKBox verticalBoxWithSpacing:0 sameSize:NO];
  [box setBorderWidth:5];
  {
    GTKBoxLayoutInfo *hboxLayout;
    GTKBox *hbox = nil;

    hboxLayout = [GTKBoxLayoutInfo layoutWithPadding:5 doExpand:NO doFill:YES];

    hbox = [GTKBox horizontalBoxWithSpacing:0 sameSize:NO];
    [hbox setLayout:hboxLayout];
    {
      GTKBox        *vbox    = nil;
      GTKLabel      *label   = nil;
      GTKSpinButton *spinner = nil;

      vbox = [GTKBox verticalBoxWithSpacing:0 sameSize:NO];
      [vbox setLayout:[GTKBoxLayoutInfo layoutWithPadding:5]];
      {
        label = [GTKLabel labelWithTitle:@"Value :" alignment:0:0.5];
        [label setLayout:[GTKBoxLayoutInfo layoutWithNoExpand]];

        spinner = [GTKSpinButton spinButtonWithClimbRate:1.0 andDigitsAfterComma:2];
        [spinner setLayout:[GTKBoxLayoutInfo layoutWithNoExpand]];
        [spinner setMinValue:-10000.0];
        [spinner setMaxValue:10000.0];
        [spinner setPageSize:100.0];
        [spinner setDoubleValue:0.0];
        [spinner setStepSize:0.5];
        _ctrl->valueSpin = spinner;

        [vbox addSubWidgets:label, spinner, nil];
      }
      [hbox addSubWidget:vbox];

      vbox = [GTKBox verticalBoxWithSpacing:0 sameSize:NO];
      [vbox setLayout:[GTKBoxLayoutInfo layoutWithPadding:5]];
      {
        label = [GTKLabel labelWithTitle:@"Digits :" alignment:0:0.5];
        [label setLayout:[GTKBoxLayoutInfo layoutWithNoExpand]];

        spinner = [GTKSpinButton spinButtonWithRange:1:5 wraps:YES];
        [spinner setIntValue:2];
        [spinner setPageSize:1];
        [spinner setLayout:[GTKBoxLayoutInfo layoutWithNoExpand]];
        [spinner setTarget:_ctrl];
        [spinner setAction:@selector(updateDigits:)];

        [vbox addSubWidgets:label, spinner, nil];
      }
      [hbox addSubWidget:vbox];
    }
    [box addSubWidget:hbox];

    [box addSubWidget:[GTKCheckButton buttonWithTitle:@"Snap to 0.5-ticks"]];
    [box addSubWidget:[GTKCheckButton buttonWithTitle:@"Numeric only input mode"]];

    hbox = [GTKBox horizontalBoxWithSpacing:0 sameSize:NO];
    [hbox setLayout:hboxLayout];
    {
      GTKButton *asInt, *asFloat;
      asInt   = [GTKButton buttonWithTitle:@"Value as Int"];
      asFloat = [GTKButton buttonWithTitle:@"Value as Float"];
      [asInt   setTarget:_ctrl];
      [asFloat setTarget:_ctrl];
      [asInt   setAction:@selector(showAsInt:)];
      [asFloat setAction:@selector(showAsFloat:)];

      [hbox addSubWidgets:asInt, asFloat, nil];
    }
    [box addSubWidget:hbox];

    [box addSubWidget:(_ctrl->valueLabel = [GTKLabel labelWithTitle:@"value"])];
  }
  return [GTKFrame frameWithTitle:@"Accelerated" content:box];
}

id makeSpinButtonWindow(NSString *_title, id _ctrl) {
  GTKWindow *window = makeTestWindowWithTitle(_title);
  GTKBox    *rootBox;

  rootBox = [GTKBox verticalBoxWithSpacing:0 sameSize:NO];
  [window setContentWidget:rootBox];

  {
    GTKBox *box = nil;

    box = [GTKBox verticalBoxWithSpacing:5 sameSize:NO
                  contents:
                    makeNotAcceleratedFrame(),
                    makeAcceleratedFrame(AUTORELEASE([SpinController new])),
                    nil];
    
    [box setBorderWidth:5];
    [rootBox addSubWidget:box];
  }
  
  [rootBox addSubWidget:[GTKSeparator horizontalSeparator]];
  [rootBox addSubWidget:makeOrderOutButton(window)];
  return window;
}

@implementation SpinController

- (void)showAsInt:(id)_sender {
  [valueLabel takeIntValueFrom:valueSpin];
}
- (void)showAsFloat:(id)_sender {
  [valueLabel takeStringValueFrom:valueSpin];
}

- (void)updateDigits:(id)_digitsSpin {
  [valueSpin setDigitsAfterComma:[_digitsSpin intValue]];
}

@end
