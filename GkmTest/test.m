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
// $Id: test.m,v 1.6 1998/08/10 01:58:54 helge Exp $

#import <Foundation/Foundation.h>
#import <GDKKit/GDKKit.h>
#import <GTKKit/GTKKit.h>
#import <GkmParse/GkmParse.h>
#import "MainController.h"
#import "SpinController.h"

// GDK Stuff
GDKScreen *screen = nil;

// GTK Stuff
GTKApplication *GTKApp   = nil;
MainController *mainCtrl = nil;
SpinController *spinCtrl = nil;

id makeMenuWindow(id _ctrl);

void logGdkInfo(void) {
  GDKVisual *visual = nil;
  
  fprintf(stderr, "%s\n", [[screen description] cString]);

  visual = [GDKVisual systemVisual];
  if (visual)
    fprintf(stderr, "SystemVisual: %s\n", [[visual description] cString]);

  visual = [GDKVisual bestVisual];
  if (visual)
    fprintf(stderr, "BestVisual: %s\n", [[visual description] cString]);
}

void gkmMain(int argc, char **argv, char **env) {
  // create application object and menu window
  GTKApp = [[GTKApplication alloc]
                            initWithArguments:argv
                            count:argc
                            environment:env];
  screen = [GDKScreen screen];
  logGdkInfo();

  mainCtrl = [[MainController alloc] init];
  spinCtrl = [[SpinController alloc] init];
  [GTKApp setDelegate:mainCtrl];
  [GTKApp loadWindowsFromModule:@"test.gkm" owner:mainCtrl];
  [GTKApp loadWindowsFromModule:@"spin.gkm" owner:spinCtrl];

  // start event loop
  [GTKApp run];

  // release application and controller
  [GTKApp release];
  GTKApp = nil;
}

int main(int argc, char **argv, char **env) {
  NSAutoreleasePool *pool = nil;

#if LIB_FOUNDATION_LIBRARY
  [NSProcessInfo initializeWithArguments:argv count:argc environment:env];
#endif

  pool = [NSAutoreleasePool new];
  NS_DURING {
    gkmMain(argc, argv, env);
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
LINK_GkmParse;
