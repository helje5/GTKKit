/*
   GTKUtilities.m

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

// $Id: GTKUtilities.m,v 1.5 1998/07/11 15:16:06 helge Exp $

#import "common.h"
#import "GTKUtilities.h"
#import "GTKWidget.h"
#import "GTKSignalEvent.h"

const char *GTKDataSelf = "self";

@interface GTKCallback : NSObject
{
  void *callback;
}
+ (id)callback:(void *)_function;
- (id)initWithCallback:(void *)_function;
@end

@implementation GTKCallback
+ (id)callback:(void *)_function {
  return [[[self alloc] initWithCallback:_function] autorelease];
}
- (id)initWithCallback:(void *)_function {
  if ((self = [super init])) {
    callback = _function;
  }
  return self;
}
@end

id gtkObjectifyArgument(GtkArg *arg) {
  id value = nil;
  
  switch (arg->type) {
    case GTK_TYPE_CHAR:
      value = [NSNumber numberWithChar:arg->d.char_data];
      break;
    case GTK_TYPE_BOOL:
      value = [NSNumber numberWithBool:(arg->d.bool_data) ? YES : NO];
      break;
    case GTK_TYPE_INT:
      value = [NSNumber numberWithInt:arg->d.int_data];
      break;
    case GTK_TYPE_UINT:
      value = [NSNumber numberWithUnsignedInt:arg->d.uint_data];
      break;
    case GTK_TYPE_LONG:
      value = [NSNumber numberWithLong:arg->d.long_data];
      break;
    case GTK_TYPE_ULONG:
      value = [NSNumber numberWithUnsignedLong:arg->d.ulong_data];
      break;
    case GTK_TYPE_FLOAT:
      value = [NSNumber numberWithFloat:arg->d.float_data];
      break;
    case GTK_TYPE_DOUBLE:
      value = [NSNumber numberWithDouble:arg->d.double_data];
      break;
    case GTK_TYPE_STRING:
      value = [NSString stringWithCString:arg->d.string_data];
      break;

    case GTK_TYPE_CALLBACK:
      value = [GTKCallback callback:arg->d.pointer_data];
      break;
      
    case GTK_TYPE_POINTER:
      value = [NSValue valueWithPointer:arg->d.pointer_data];
      break;

    case GTK_TYPE_OBJECT: {
      GtkObject *gtkObj = arg->d.object_data;
      id        obj =GTKGetObject(gtkObj);
      return obj ? obj : [NSValue valueWithPointer:gtkObj];
      break;
    }

    default:
      value = [NSValue valueWithPointer:arg];
      break;
  }
  return value;
}

// the marshaller, much of the work is done in GTKSignalEvent now.
void gtkSignalMarshaller(GtkObject *_obj, gpointer _context,
                         guint n_args, GtkArg *args) {
  GTKObject      *receiver = nil;
  GTKSignalEvent *event    = nil;
  NSString       *signame  = nil;

  receiver = GTKGetObject(_obj);
  signame  = _context ? [NSString stringWithCString:(char *)_context] : @"<none>";

  event = [GTKSignalEvent eventWithSignalName:signame
                          receiver:receiver
                          arguments:args count:n_args];

  if (getenv("LOG_GTK"))
    printf("%s\n", [[event description] cString]);

  [receiver handleEvent:event];
  // WAS: [receiver handleSignal:signame arguments:argDict];
}

id GTKGetObject(void *_gtkObj) {
  return _gtkObj
    ? ((id)gtk_object_get_data((GtkObject *)_gtkObj, GTKDataSelf))
    : nil;
}

// descriptions

NSString *GTKJustificationDescription(GtkJustification _mode) {
  // This returns a description for the given justification enum value
  
  switch (_mode) {
    case GTK_JUSTIFY_LEFT:    return @"left";
    case GTK_JUSTIFY_RIGHT:   return @"right";
    case GTK_JUSTIFY_CENTER:  return @"center";
    case GTK_JUSTIFY_FILL:    return @"fill";
  }
  return @"<unknown justification>";
}

NSString *GTKSelectionModeDescription(GtkSelectionMode _mode) {
  // This returns a description for the given selection mode

  switch (_mode) {
    case GTK_SELECTION_SINGLE:   return @"single";
    case GTK_SELECTION_BROWSE:   return @"browse";
    case GTK_SELECTION_MULTIPLE: return @"multiple";
    case GTK_SELECTION_EXTENDED: return @"extended";
  }
  return @"<unknown selection mode>";
}
