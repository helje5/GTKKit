/*
   GKModuleParser.m

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

// $Id: GKModuleParser.m,v 1.19 1998/08/10 01:42:16 helge Exp $

#include <stdio.h>
#include "pcctscfg.h"
#import  "GKMAttribute.h"
#include "dlgdef.h"
#include "antlr.h"
#include "tokens.h"

#import "common.h"
#import "GKModuleParser.h"
#import "GKModule.h"
#import "GKMAttribute.h"

GKModuleParser *activeParser = nil;

@implementation GKModuleParser

static NSString *activeFile = nil;

// error synchronizer

void zzsyn(char *text, int tok, char *egroup, SetWordType *eset,
           int etok, int k, char *bad_text) {
  
  zzSyntaxErrCount++;

  fprintf(stderr, "%s:%d: syntax error at '%s'",
          activeFile ? [activeFile cString] : "<none>",
          zzline, (tok == zzEOF_TOKEN) ? "EOF" : bad_text);
  if (!etok && !eset) {
    fprintf(stderr, "\n");
    return;
  }
  if (k == 1)
    fprintf(stderr, " missing");
  else {
    fprintf(stderr, "; \"%s\" not", bad_text);
    if (zzset_deg(eset) > 1) fprintf(stderr, " in");
  }
  if (zzset_deg(eset) > 0)
    zzedecode(eset);
  else
    fprintf(stderr, " %s", zztokens[etok]);
  if (strlen(egroup) > 0)
    fprintf(stderr, " in %s", egroup);
  fprintf(stderr, "\n");

  { // print object backtrace
    int cnt;
    
    fprintf(stderr, "  element stack:\n");
    for (cnt = activeParser->stackPtr; cnt > 0; cnt--) {
      id object = activeParser->objectStack[cnt];

      if (object)
        fprintf(stderr, "    0x%08X<%s>\n",
                (unsigned)object,
                [[[object class] description] cString]);
      else
        fprintf(stderr, "    <nil>\n");
    }
  }
}

// parser stack

static inline void pushParser(GKModuleParser *_parser) {
  activeParser = RETAIN(_parser);
}
static inline void popParser(GKModuleParser *_parser) {
  NSCAssert(activeParser == _parser, @"broken parser stack ..");
  RELEASE(activeParser);
  activeParser = nil;
}

- (id)init {
  if ((self = [super init])) {
    objectStack[0] = nil;
    stackPtr = 0;

    delayedProperties = [[NSMutableArray alloc] initWithCapacity:64];
    radioGroups       = [[NSMutableDictionary alloc] initWithCapacity:16];
  }
  return self;
}

#if !LIB_FOUNDATION_BOEHM_GC
- (void)dealloc {
  RELEASE(delayedProperties); delayedProperties = nil;
  RELEASE(radioGroups);       radioGroups       = nil;
  [super dealloc];
}
#endif

// parsing

- (void)resolveRadioGroups {
  NSEnumerator *groups    = [radioGroups keyEnumerator];
  NSString     *groupName = nil;

  while ((groupName = [groups nextObject])) {
    NSEnumerator   *elements = [[radioGroups objectForKey:groupName] objectEnumerator];
    GTKRadioButton *current  = nil;
    GTKRadioButton *last     = nil;

    last    = [elements nextObject]; // first object, queue is NULL
    current = last ? [elements nextObject] : nil;
    while (current) {
      NSLog(@"set parent of 0x%08X", (unsigned)current);

      last = current;
      current = [elements nextObject];
    }
  }
}

- (void)resolveNameAttributes {
  NSEnumerator *ie = [delayedProperties objectEnumerator];
  NSInvocation *i;

  while ((i = [ie nextObject])) {
    id object = nil;

    [i getArgument:&object atIndex:2];

    if ([object isKindOfClass:[NSString class]]) {
      if ([object hasPrefix:@"#"]) { // a name reference
        NSString *name = [object substringFromIndex:1];

        ASSIGN(object, [module objectForName:name]);

        if (object == nil) {
          NSLog(@"WARNING: did not find object for reference '%@' (in property of %@)",
                name, [i target]);
        }

        [i setArgument:&object atIndex:2];
      }
    }

    //NSLog(@"invoking %@ on %@ with %@ ..",
    //      NSStringFromSelector([i selector]), [i target], object);
    [i invoke];
  }
}

- (void)parseModule:(GKModule *)_module fromPath:(NSString *)_path {
  extern void gkmodule(void);
  FILE *f = fopen([_path cString], "r");

  if (f == NULL) {
    NSLog(@"ERROR: could not open module file '%@' ..", _path);
    return;
  }

  ASSIGN(activeFile, _path);

  [delayedProperties removeAllObjects];
  [radioGroups       removeAllObjects];
  stackPtr = 0;
  module   = RETAIN(_module);

  {
    NSAutoreleasePool *pool = [NSAutoreleasePool new];

    pushParser(self);
    NS_DURING {
      ANTLR(gkmodule(), f);
    }
    NS_HANDLER {
      popParser(self);
      fclose(f); f = NULL;
      RELEASE(module); module = nil;
    
      [localException raise];
    }
    NS_ENDHANDLER;
    popParser(self);
    fclose(f); f = NULL;

    [self resolveRadioGroups];
    [radioGroups removeAllObjects];

    [self resolveNameAttributes];
    [delayedProperties removeAllObjects];
    
    RELEASE(pool); pool = nil;
  }
  RELEASE(module); module = nil;

  ASSIGN(activeFile, nil);
  stackPtr = 0;
}

// object stack

- (void)pushObject:(id)_object {
  stackPtr++;
  NSCAssert(stackPtr < (sizeof(objectStack)/sizeof(id)), @"object stack size exceeded");
  objectStack[stackPtr] = RETAIN(_object);
}
- (id)popObject {
  id obj;
  obj = objectStack[stackPtr];
  objectStack[stackPtr] = nil;
  stackPtr--;
  return AUTORELEASE(obj);
}

- (id)currentObject {
  return objectStack[stackPtr];
}
- (id)parentObject {
  return objectStack[stackPtr - 1];
}

- (BOOL)isTopLevel {
  return (stackPtr <= 1);
}

// notifications

- (void)enterModule {
}
- (void)leaveModule {
}

- (id)valueForStringAttribute:(GKMAttribute *)_attribute {
  return AUTORELEASE([[_attribute text] copy]);
}
- (id)valueForIntAttribute:(GKMAttribute *)_attribute {
  return [NSNumber numberWithInt:[[_attribute text] intValue]];
}
- (id)valueForFloatAttribute:(GKMAttribute *)_attribute {
  return [NSNumber numberWithDouble:[[_attribute text] doubleValue]];
}

- (id)valueForReferenceAttribute:(GKMAttribute *)_attribute {
  return AUTORELEASE(RETAIN(_attribute));
}
- (id)valueForSelectorAttribute:(GKMAttribute *)_attribute {
  // return selector name, strip of leading '@'
  return [[_attribute text] substringFromIndex:1];
}

- (id)valueForBoolAttribute:(GKMAttribute *)_attribute {
  return [NSNumber numberWithBool:[[[_attribute text] uppercaseString]
                                                isEqualToString:@"YES"]];
}

- (id)valueForLayoutType:(NSString *)_layoutType values:(NSDictionary *)_values {
  NSString      *layoutType = [_layoutType lowercaseString];
  GTKLayoutInfo *layoutInfo = nil;

  if ([layoutType isEqualToString:@"fixed"])
    layoutInfo = [module produceFillLayoutWithValues:_values];
  else if ([layoutType isEqualToString:@"box"])
    layoutInfo = [module produceBoxLayoutWithValues:_values];
  else if ([layoutType isEqualToString:@"table"])
    layoutInfo = [module produceTableLayoutWithValues:_values];
  else
    NSLog(@"WARNING: Unknown layout type %@", layoutType);

  // NSLog(@"produced layout info: %@", layoutInfo);
  
  return AUTORELEASE(RETAIN(layoutInfo));
}

- (id)valueForAutomaticAttribute:(GKMAttribute *)_attribute {
  return [NSNumber numberWithInt:GTK_POLICY_AUTOMATIC];
}
- (id)valueForAlwaysAttribute:(GKMAttribute *)_attribute {
  return [NSNumber numberWithInt:GTK_POLICY_ALWAYS];
}

// elements

- (void)setElementName:(NSString *)_name {
  // NSLog(@"  => element name %@", _name);

  if (elementType == GKM_Object)
    [self pushObject:[module objectForName:_name]];
  else
    [module registerObject:[self currentObject] withName:_name];
  assignedName = YES;
}

- (void)setElementRadioGroup:(NSString *)_group {
  NSMutableArray *array = [radioGroups objectForKey:_group];

  if (array == nil) {
    array = [[NSMutableArray alloc] initWithCapacity:16];
    [radioGroups setObject:array forKey:_group];
    RELEASE(array);
  }

  [array addObject:[self currentObject]];
}

- (void)setElementPosition:(int)_x:(int)_y {
  [[self currentObject] setPosition:_x:_y];
}
- (void)setElementSize:(int)_width:(int)_height {
  [[self currentObject] setSize:_width:_height];
}

- (void)setValue:(id)_value forProperty:(GKMAttribute *)_name {
  NSInvocation *setInvocation   = nil;
  BOOL         lastWasReference = NO;

  if ([_value isKindOfClass:[GKMAttribute class]]) {
    lastWasReference = YES;
    _value = [_value text];
  }

  setInvocation = [module invocationToSetValue:_value
                          forProperty:[_name text]
                          ofObject:[self currentObject]];
  if (setInvocation == nil) {
    NSLog(@"WARNING: could not set value for property %@ of object %@",
          [_name text], [self currentObject]);
    return;
  }

  if (lastWasReference) {
    // NSLog(@"queued invocation for delayed execution ..");
    [delayedProperties addObject:setInvocation];
  }
  else
    [setInvocation invoke];
}

- (void)beginObjectElement {
  elementType = GKM_Object;
}
- (void)endObjectElement {
  id obj = [self popObject];
  if (!assignedName) {
    NSLog(@"ERROR: no name was assigned to object !");
  }
}

- (void)applyAssignment:(GKMAttribute *)_name
  assign:(id)_value to:(GKMAttribute *)_property {

  [self setValue:_value forProperty:_property];
}

- (void)beginGenericElement:(GKMAttribute *)_name {
  id parentElement = [self currentObject];
  id element;

  // reset temporaries
  assignedName = NO;
  elementType  = GKM_Generic;

  element = [module produceObjectForName:[_name text]];
  [self pushObject:element];
}

- (void)startGenericElement:(GKMAttribute *)_name {
  // All attributes where read & assigned. Now add the widget to it's parent.
  id parentObject = [self parentObject];
  id object       = [self currentObject];

  //NSLog(@"start %selement %@", [self isTopLevel] ? "TopLevel-" : "",  _name);

  if (![self isTopLevel]) {
    if (object) {
      if ([parentObject isKindOfClass:[GTKContainer class]])
        [module addSubWidget:object toContainer:parentObject];
      else {
        NSLog(@"ERROR: could not add element %@ to parent %@", object, parentObject);
      }
    }
  }
}

- (void)endGenericElement:(GKMAttribute *)_name {
  id element = [self popObject];
  //NSLog(@"finished element %@", element);
}

- (void)beginGenericElementContent:(GKMAttribute *)_name {
}
- (void)endGenericElementContent:(GKMAttribute *)_name {
}

@end
