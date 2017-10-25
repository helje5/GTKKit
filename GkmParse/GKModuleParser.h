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

// $Id: GKModuleParser.h,v 1.14 1998/08/16 20:01:19 helge Exp $

#import <Foundation/NSObject.h>

@class NSString, NSDictionary, NSMutableDictionary, NSMutableArray;
@class GKModule;
@class GKMAttribute;

typedef enum {
  GKM_Reference,
  GKM_Object,
  GKM_Generic
} GKMElementType;

@interface GKModuleParser : NSObject
{
  GKModule *module;

  id       objectStack[80];
  unsigned stackPtr;

  // transients used during parsing of a start-tag
  GKMElementType      elementType;         // is it an reference or an element ?
  NSMutableDictionary *attributeCache;     // used during reading of first tag
  NSString            *assignedName;       // the current element had an ID attribute
  NSString            *assignedRadioGroup; // radio group of current element
  BOOL                assignedSize;
  BOOL                assignedPosition;
  gfloat              x, y;
  gfloat              width, height;

  // delayed execution & resolution of radio groups & names
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

// attribute values

- (id)valueForString:(GKMAttribute *)_attribute    attribute:(NSString *)_name;
- (id)valueForInt:(GKMAttribute *)_attribute       attribute:(NSString *)_name;
- (id)valueForFloat:(GKMAttribute *)_attribute     attribute:(NSString *)_name;
- (id)valueForReference:(GKMAttribute *)_attribute attribute:(NSString *)_name;
- (id)valueForSelector:(GKMAttribute *)_attribute  attribute:(NSString *)_name;
- (id)valueForBool:(GKMAttribute *)_attribute      attribute:(NSString *)_name;
- (id)valueForLayoutType:(NSString *)_type values:(NSDictionary *)_values;
- (id)valueForAutomatic:(GKMAttribute *)_attribute attribute:(NSString *)_name;
- (id)valueForAlways:(GKMAttribute *)_attribute    attribute:(NSString *)_name;

// elements

- (void)beginObjectElement;
- (void)endObjectElement;
- (void)beginReferenceElement;
- (void)endReferenceElement;
- (void)applyAssignment:(GKMAttribute *)_name
  assign:(id)_value to:(GKMAttribute *)_property;

- (void)beginGenericElement:(GKMAttribute *)_name; // called before attributes
- (void)startGenericElement:(GKMAttribute *)_name; // called after attributes
- (void)endGenericElement:(GKMAttribute *)_name;   // called after end-tag
- (void)beginGenericElementContent:(GKMAttribute *)_name;
- (void)endGenericElementContent:(GKMAttribute *)_name;

- (void)setElementName:(NSString *)_name;
- (void)setElementRadioGroup:(NSString *)_group;
- (void)setElementPosition:(int)_x:(int)_y;
- (void)setElementSize:(int)_width:(int)_height;
- (void)setValue:(id)_value forProperty:(GKMAttribute *)_name;

@end
