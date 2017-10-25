/*
   oldtest.m

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
// $Id: oldtest.m,v 1.1 1998/07/09 06:18:27 helge Exp $

#import <Foundation/Foundation.h>
#import <GTKKit/GTKKit.h>
#import "MyProgressBar.h"
#import "MyController.h"

GTKApplication *GTKApp = nil;

GTKTable *makeTableTest(void) {
  GTKTable *table = [GTKTable tableWithSize:3:3 sameSize:YES];
  
  [table addSubWidget:[GTKToggleButton buttonWithTitle:@"2031"]
         fromPoint:2:0 toPoint:3:1]; // place in right/top
  [table addSubWidget:[GTKToggleButton buttonWithTitle:@"1122"]
         fromPoint:1:1 toPoint:2:2]; // place in middle
  [table addSubWidget:[GTKToggleButton buttonWithTitle:@"0033"]
         fromPoint:0:2 toPoint:3:3]; // bottom line

  [table setRowSpacings:2];

  return table;
}

GTKWidget *makeRadioTest(void) {
  GTKHorizBox *box = [GTKHorizBox horizontalBoxWithSpacing:1 sameSize:YES];
  GTKRadioButton *radio;

  [box addSubWidget:(radio = [GTKRadioButton radioButtonWithTitle:@"1.1"])];
  [box addSubWidget:[GTKRadioButton radioButtonWithTitle:@"2.1" addedTo:radio]];
  [box addSubWidget:[GTKRadioButton radioButtonWithTitle:@"3.1" addedTo:radio]];

  return box;
}

GTKEntry *entry;

GTKEntry *makeEntryTest(void) {
  entry = [GTKEntry textEntry];
  [entry setEditable:YES];
  [entry setStringValue:@"hallo .."];
  [entry selectText:nil];
  [entry setToolTip:[entry description]];
  return entry;
}

GTKText *texter = nil;

GTKWidget *makeTextTest(void) {
  GTKPaned *group  = nil;
  GTKEntry *entry  = nil;

  group = [GTKPaned verticalPaned];

  [group setFirstWidget:(entry = makeEntryTest())];
  
  [group setSecondWidget:(texter = [GTKText text])];
  [texter setEditable:YES];
  [texter setToolTip:[texter description]];
  [texter setStringValue:@"hallo"];

  [entry setTarget:texter];
  [entry setAction:@selector(takeStringValueFrom:)];

  //  group = [GTKVertBox vertBox];
  // [group addSubWidget:group];
  return group;
}

GTKMenuItem *openItem = nil;
GTKMenuItem *saveItem = nil;
GTKMenuItem *quitItem = nil;

GTKMenuBar *makeMenu(void) {
  GTKMenuBar  *menuBar  = [GTKMenuBar menubar];
  GTKMenu     *appMenu  = [GTKMenu menu];
  GTKMenuItem *appItem  = [GTKMenuItem menuItemWithTitle:@"Test"];

  openItem = [GTKMenuItem menuItemWithTitle:@"Open"];
  saveItem = [GTKMenuItem menuItemWithTitle:@"Save"];
  quitItem = [GTKMenuItem menuItemWithTitle:@"Quit"];
  
  [appMenu appendWidget:openItem];
  [appMenu appendWidget:saveItem];
  [appMenu appendWidget:quitItem];

  [openItem show];
  [saveItem show];
  [quitItem show];

  [quitItem setTarget:GTKApp];
  [quitItem setAction:@selector(terminate:)];
  
  [appItem show]; // the title
  [appItem setSubMenu:appMenu];

  [menuBar appendWidget:appItem];

  return menuBar;
}

id makeList(id ctrl, SEL sel) {
  GTKScrolledWindow *scroll;
  GTKList           *list = [GTKList list];
  int               cnt;

  [list setSelectionMode:GTK_SELECTION_MULTIPLE];
  
  for (cnt = 0; cnt < 30; cnt++) {
    NSString    *title;
    GTKListItem *item;

    title = [NSString stringWithFormat:@"item %i", cnt];
    item = [GTKListItem listItemWithTitle:title];
    [item setRepresentedObject:title];

    [list addSubWidget:item];
  }

  [list setTarget:ctrl];
  [list setAction:sel];
  
  scroll = [GTKScrolledWindow scrolledWindowWithContent:list];
  [scroll setHorizScrollbarPolicy:GTK_POLICY_AUTOMATIC];
  [scroll setVertScrollbarPolicy:GTK_POLICY_AUTOMATIC];
  return scroll;
}

id makeTableList(id ds) {
  GTKBox       *vbox = nil, *hbox = nil;
  GTKTableList *tl  = [GTKTableList tableListWithWidth:3];
  GTKButton    *reload, *clear, *selAll, *deselAll;

  [tl setRowHeight:16];
  [tl setDataSource:ds];
  [tl setTitle:@"eins" andWidth:80  ofColumn:0];
  [tl setTitle:@"zwei" andWidth:30  ofColumn:1];
  [tl setTitle:@"drei" andWidth:120 ofColumn:2];
  [tl setJustification:GTK_JUSTIFY_RIGHT ofColumn:2];
  [tl setShowsTitles:YES];
  [tl setTarget:ds];
  [tl setAction:@selector(tableListChanged:)];

  reload   = [GTKButton buttonWithTitle:@"reload"];
  clear    = [GTKButton buttonWithTitle:@"clear"];
  selAll   = [GTKButton buttonWithTitle:@"select all"];
  deselAll = [GTKButton buttonWithTitle:@"deselect all"];

  [reload   setTarget:tl];
  [clear    setTarget:tl];
  [selAll   setTarget:tl];
  [deselAll setTarget:tl];
  [reload   setAction:@selector(reload:)];
  [clear    setAction:@selector(clear:)];
  [selAll   setAction:@selector(selectAll:)];
  [deselAll setAction:@selector(deselectAll:)];
  
  hbox = [GTKHorizBox horizontalBoxWithSpacing:1 sameSize:YES];
  [hbox addSubWidget:reload];
  [hbox addSubWidget:clear];
  [hbox addSubWidget:selAll];
  [hbox addSubWidget:deselAll];

  vbox = [GTKVertBox verticalBoxWithSpacing:3 sameSize:NO];
  [vbox addSubWidget:tl];
  [vbox addSubWidget:hbox doExpand:NO];

  return vbox;
}

int main(int argc, char **argv, char **env) {
  NSAutoreleasePool *pool = nil;

#if LIB_FOUNDATION_LIBRARY
  [NSProcessInfo initializeWithArguments:argv count:argc environment:env];
#endif

  pool = [NSAutoreleasePool new];
  NS_DURING {
    GTKWindow   *window   = nil;
    GTKNotebook *notebook = nil;
    
    GTKApp = [[GTKApplication alloc]
                              initWithArguments:argv
                              count:argc
                              environment:env];

    window = [[GTKWindow alloc] init];
    [window setBorderWidth:0];
    [window setTitle:@"MyWindow"];
    [GTKApp addWindow:window];

    {
      NSAutoreleasePool *pool = [NSAutoreleasePool new];
      GTKButton     *button = nil;
      GTKBox        *topBox = nil;
      GTKBox        *hBox   = nil;
      MyProgressBar *pbar   = nil; 
      MyController  *ctrl   = [[MyController alloc] init];
      id tmp;

      [window setContentWidget:(topBox = [GTKVertBox verticalBox])];

      [topBox addSubWidget:makeMenu()
              atStart:YES
              doExpand:NO
              doFill:YES
              padding:0];
      [openItem setTarget:ctrl];
      [openItem setAction:@selector(showFileSelector:)];

      [topBox addSubWidget:(topBox = [GTKVertBox verticalBox])];
      [topBox setBorderWidth:4];
      
      [topBox addSubWidget:(notebook = [GTKNotebook notebook])];
      topBox = nil;

      [notebook appendPage:(topBox = [GTKVertBox verticalBox])
                withTitle:@"misc"];
      [notebook appendPage:makeTextTest()
                withTitle:@"text"];
      [notebook appendPage:(pbar = [MyProgressBar progressBar])
                withTitle:@"progress"]; 

      [notebook appendPage:makeTableList(ctrl)
                withTitle:@"table"];

      [notebook appendPage:makeList(ctrl, @selector(listChanged:))
                withTitle:@"list"];

      [topBox setBorderWidth:4];
      
      [topBox addSubWidget:(hBox = [GTKHorizBox horizontalBoxWithSpacing:1
                                                sameSize:YES])
              atStart:YES doExpand:YES doFill:YES padding:1];
    
      [topBox addSubWidget:[GTKLabel labelWithTitle:@"MyLabel"]];
      
      [hBox addSubWidget:[GTKButton buttonWithTitle:@"1"]
            atStart:YES doExpand:YES doFill:YES padding:1];
      [hBox addSubWidget:[GTKButton buttonWithTitle:@"2"]
            atStart:YES doExpand:YES doFill:YES padding:1];
      [hBox addSubWidget:[GTKButton buttonWithTitle:@"3"]
            atStart:YES doExpand:YES doFill:YES padding:1];

      [topBox addSubWidget:
                (button = [GTKButton buttonWithTitle:@"show dialog"])];
      [button setTarget:ctrl];
      [button setAction:@selector(showDialog:)];
      [button setToolTip:[button description]];

      [topBox addSubWidget:makeTableTest()];
      [topBox addSubWidget:makeRadioTest()];

      { // scale test
        GTKEntry     *entry;
        GTKScale     *scale;
        GTKScrollbar *scrollbar;
        
        [topBox addSubWidget:(entry = [GTKEntry textEntry])];
        [entry setDoubleValue:0.0];
        [entry setEditable:YES];
      
        [topBox addSubWidget:(scale = [GTKScale horizontalScale])];
        [scale setDigitsAfterComma:2];
        [scale setDrawsValue:YES];
        [scale setContinuous:YES];
        // [scale setMinValue:20.0];
        // [scale setMaxValue:100.0];
        [scale setDoubleValue:0.5];

        [topBox addSubWidget:(scrollbar = [GTKScrollbar horizontalScrollbar])];
        [scrollbar setContinuous:YES];
        [scrollbar setPageSize:1];
        [scrollbar setPageCount:5];

        [entry     setTarget:scale];
        [scale     setTarget:scrollbar];
        [scrollbar setTarget:entry];
        [entry     setAction:@selector(takeDoubleValueFrom:)];
        [scale     setAction:@selector(takeDoubleValueFrom:)];
        [scrollbar setAction:@selector(takeDoubleValueFrom:)];
      }
      
      [window orderFront:nil];

      // [texter setStringValue:[texter description]];
      // [texter appendString:@"\nHallo Welt !\n"];

      [GTKTimer timerWithTimeInterval:0.3
                target:pbar selector:@selector(increment:)
                userInfo:nil
                repeats:YES];
      
      [GTKApp run];

      [ctrl release];
      [GTKApp release];
      GTKApp = nil;
    
      [pool release];
      pool = nil;
    }
  }
  NS_HANDLER {
    fprintf(stderr, "main catched: %s\n",
            [[localException description] cString]);
  }
  NS_ENDHANDLER;
  
  [pool release];
  pool = nil;
  
  return 0;
}
