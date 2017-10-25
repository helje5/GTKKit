/*
   NSArray+GList.m

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

// $Id: NSArray+GList.m,v 1.2 1998/08/05 18:14:37 helge Exp $

#import <Foundation/NSValue.h>
#import "NSArray+GList.h"

@implementation NSArray(GListSupport)

static void addToArray(gpointer _data, gpointer _array) {
  NSValue *value = [NSValue valueWithPointer:_data];
  [(NSMutableArray *)_array addObject:value];
}

+ (id)arrayFromPointerGList:(GList *)_list {
  gint           _len   = g_list_length(_list);
  NSMutableArray *array = [NSMutableArray arrayWithCapacity:_len + 1];
  g_list_foreach(_list, addToArray, (gpointer)self);
  return array;
}

- (GList *)pointerGList {
  GList *list = g_list_alloc();
  int   cnt, total = [self count];
  for (cnt = 0; cnt < total; cnt++) {
    id obj = [self objectAtIndex:cnt];
    g_list_append(list, (gpointer)obj);
  }
  return list;
}
- (GList *)retainedObjectsGList {
  GList *list = g_list_alloc();
  int   cnt, total = [self count];
  for (cnt = 0; cnt < total; cnt++) {
    id obj = [self objectAtIndex:cnt];
    g_list_append(list, (gpointer)[obj retain]);
  }
  return list;
}
- (GList *)intGList {
  GList *list = g_list_alloc();
  int   cnt, total = [self count];
  for (cnt = 0; cnt < total; cnt++) {
    id obj = [self objectAtIndex:cnt];
    g_list_append(list, (gpointer)[obj intValue]);
  }
  return list;
}

@end
