/*
   GKModule.h

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

// $Id: GKModule.h,v 1.11 1998/08/16 19:17:33 helge Exp $

#import <Foundation/NSObject.h>

@class NSMutableDictionary, NSZone, NSInvocation, NSEnumerator, NSDictionary;
@class GTKWidget, GTKContainer;

@interface GKModule : NSObject
{
  NSMutableDictionary *nameToObject;
  NSZone *objectZone;
}

+ (GKModule *)moduleFromPath:(NSString *)_path owner:(id)_owner;

// name service

- (void)registerObject:(id)_object;
- (void)registerObject:(id)_object withName:(NSString *)_name;
- (id)objectForName:(NSString *)_name;
- (NSEnumerator *)allNamedObjectsOfClass:(Class)_class;

// factory

- (id)produceObjectForName:(NSString *)_tagName attributes:(NSDictionary *)_attrs;
- (id)produceFixedLayoutWithValues:(NSDictionary *)_values;
- (id)produceBoxLayoutWithValues:(NSDictionary *)_values;
- (id)produceTableLayoutWithValues:(NSDictionary *)_values;

- (void)addSubWidget:(GTKWidget *)_widget toContainer:(GTKContainer *)_container;

- (NSInvocation *)invocationToSetValue:(id)_value
  forProperty:(NSString *)_property
  ofObject:(id)_object;

@end
