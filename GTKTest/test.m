/*
   test.m

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
// $Id: test.m,v 1.6 1998/08/06 02:01:24 helge Exp $

#import <Foundation/Foundation.h>
#import <GDKKit/GDKKit.h>
#import <GTKKit/GTKKit.h>
#import "MyController.h"


// GDK Stuff
GDKScreen *screen = nil;

// GTK Stuff
GTKApplication *GTKApp     = nil;
MyController   *ctrl       = nil;
GTKWindow      *mainWindow = nil;

id makeMenuWindow(id _ctrl);

void logGdkInfo(void) {
  GDKFont   *font   = nil;
  GDKVisual *visual = nil;
  
  fprintf(stderr, "%s\n", [[screen description] cString]);

  // try some font
  font = [GDKFont fontWithName:
                    @"-adobe-helvetica-medium-r-normal--*-120-*-*-*-*-*-*"];
  if (font) {
    fprintf(stderr, "%s\n", [[font description] cString]);
    fprintf(stderr, "  'hello' is %3g points long ..\n",
            [font widthOfString:@"hello"]);
    fprintf(stderr, "         and %3g points high ..\n",
            [font heightOfString:@"hello"]);
  }
  else {
    fprintf(stderr, "could not load font: %s\n",
            "-adobe-helvetica-medium-r-normal--*-120-*-*-*-*-*-*");
  }

  visual = [GDKVisual systemVisual];
  if (visual)
    fprintf(stderr, "SystemVisual: %s\n", [[visual description] cString]);

  visual = [GDKVisual bestVisual];
  if (visual)
    fprintf(stderr, "BestVisual: %s\n", [[visual description] cString]);
}

int main(int argc, char **argv, char **env) {
  NSAutoreleasePool *pool = nil;

#if LIB_FOUNDATION_LIBRARY
  [NSProcessInfo initializeWithArguments:argv count:argc environment:env];
#endif

  //[NSAutoreleasePool enableRetainRemove:NO];

  pool = [NSAutoreleasePool new];
  NS_DURING {
    // create application object and menu window
    NSAutoreleasePool *initPool = [NSAutoreleasePool new];
    {
      GTKApp = [[GTKApplication alloc]
                                initWithArguments:argv
                                count:argc
                                environment:env];

      screen = [GDKScreen screen];
      logGdkInfo();
      
      ctrl = [MyController new];

      // add window to application
      [GTKApp addWindow:(mainWindow = makeMenuWindow(ctrl))];
    }
    [initPool release]; initPool = nil;

    // make menu window appear on screen
    [mainWindow orderFront:nil];
    
    // start event loop
    [GTKApp run];

    // release application and controller
    [ctrl   release]; ctrl   = nil;
    [GTKApp release]; GTKApp = nil;
  }
  NS_HANDLER {
    fprintf(stderr, "Exception: %s\n  reason: %s\n  userInfo: %s\n",
            [[localException name] cString],
            [[localException reason] cString],
            [[[localException userInfo] description] cString]);
    abort();
  }
  NS_ENDHANDLER;
  [pool release]; pool = nil;
  
  return 0;
}

LINK_GTKKit;
LINK_GDKKit;
