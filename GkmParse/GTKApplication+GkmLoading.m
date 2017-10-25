/*
   GTKApplication+GkmLoading.h

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

// $Id: GTKApplication+GkmLoading.m,v 1.2 1998/08/09 23:50:21 helge Exp $

#import <Foundation/Foundation.h>
#import <GTKKit/GTKKit.h>
#import "GTKApplication+GkmLoading.h"
#import "GKModule.h"
#import "GKModuleParser.h"

@implementation GTKApplication(GkmLoading)

- (BOOL)loadWindowsFromModule:(NSString *)_path {
  return [self loadWindowsFromModule:_path owner:self];
}

- (BOOL)loadWindowsFromModule:(NSString *)_path owner:(id)_owner {
  NSAutoreleasePool *pool = [NSAutoreleasePool new];
  BOOL result = NO;
  {
    GKModuleParser *parser = nil;
    GKModule       *module = [[GKModule alloc] init];

    [module registerObject:GTKApp withName:@"APP"];
    [module registerObject:self   withName:@"LOADER"];
    [module registerObject:_owner withName:@"OWNER"];

    parser = [[GKModuleParser alloc] init];
    [parser parseModule:module fromPath:_path];
    RELEASE(parser); parser = nil;

    if (module) {
      NSEnumerator *e = [module allNamedObjectsOfClass:[GTKWindow class]];
      GTKWindow    *window;

      while ((window = [e nextObject])) {
        [self addWindow:window];
      }
      result = YES;

      RELEASE(module); module = nil;
    }
  }
  RELEASE(pool); pool = nil;
  return result;
}

@end

void __link_GTKApplication_GkmLoading(void) {
  __link_GTKApplication_GkmLoading();
}
