/*
   calculator.m

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
// $Id: calculator.m,v 1.1 1998/08/16 14:58:10 helge Exp $

#import <Foundation/Foundation.h>
#import <GDKKit/GDKKit.h>
#import <GTKKit/GTKKit.h>
#import <GkmParse/GkmParse.h>

GTKApplication *GTKApp = nil;

void gkmMain(int argc, char **argv, char **env) {
  GTKApp = [[GTKApplication alloc]
                            initWithArguments:argv count:argc
                            environment:env];

  [GTKApp loadWindowsFromModule:@"calculator.gkm" owner:GTKApp];

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
            [[localException  name] cString],
            [[localException  reason] cString],
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
