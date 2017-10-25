/*
   GKModuleParser.h

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

// $Id: GKModuleParser.h,v 1.9 1998/08/10 00:36:51 helge Exp $

#import <Foundation/NSObject.h>

@class NSString, NSDictionary, NSMutableDictionary, NSMutableArray;
@class GKModule;
@class GKMAttribute;

typedef enum {
  GKM_Object,
  GKM_Generic
} GKMElementType;

@interface GKModuleParser : NSObject
{
  GKModule *module;

  id       objectStack[80];
  unsigned stackPtr;

  BOOL           assignedName;
  GKMElementType elementType;

  NSMutableArray      *delayedProperties; // for name resolution
  NSMutableDictionary *radioGroups;
}

- (void)parseModule:(GKModule *)_module fromPath:(NSString *)_path;

// object stack

- (void)pushObject:(id)_object;
- (id)popObject;

// notifications

- (void)enterModule;
- (void)leaveModule;

- (id)valueForStringAttribute:(GKMAttribute *)_attribute;
- (id)valueForIntAttribute:(GKMAttribute *)_attribute;
- (id)valueForFloatAttribute:(GKMAttribute *)_attribute;
- (id)valueForReferenceAttribute:(GKMAttribute *)_attribute;
- (id)valueForSelectorAttribute:(GKMAttribute *)_attribute;
- (id)valueForBoolAttribute:(GKMAttribute *)_attribute;
- (id)valueForLayoutType:(NSString *)_type values:(NSDictionary *)_values;
- (id)valueForAutomaticAttribute:(GKMAttribute *)_attribute;
- (id)valueForAlwaysAttribute:(GKMAttribute *)_attribute;

- (void)beginObjectElement;
- (void)endObjectElement;
- (void)applyAssignment:(GKMAttribute *)_name
  assign:(id)_value to:(GKMAttribute *)_property;

- (void)beginGenericElement:(GKMAttribute *)_name;
- (void)startGenericElement:(GKMAttribute *)_name;
- (void)endGenericElement:(GKMAttribute *)_name;
- (void)beginGenericElementContent:(GKMAttribute *)_name;
- (void)endGenericElementContent:(GKMAttribute *)_name;

- (void)setElementName:(NSString *)_name;
- (void)setElementRadioGroup:(NSString *)_group;
- (void)setElementPosition:(int)_x:(int)_y;
- (void)setElementSize:(int)_width:(int)_height;
- (void)setValue:(id)_value forProperty:(GKMAttribute *)_name;

@end
