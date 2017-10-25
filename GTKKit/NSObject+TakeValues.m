/*
   NSObject+TakeValues.m

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

// $Id: NSObject+TakeValues.m,v 1.2 1998/07/14 13:26:56 helge Exp $

#import "NSObject+TakeValues.h"

@implementation NSObject(GTKTakeValues)

- (void)takeStringValueFrom:(id)_sender {
  [self setStringValue:[_sender stringValue]];
}
- (void)takeObjectValueFrom:(id)_sender {
  [self setObjectValue:[_sender objectValue]];
}
- (void)takeIntValueFrom:(id)_sender {
  [self setIntValue:[_sender intValue]];
}
- (void)takeFloatValueFrom:(id)_sender {
  [self setFloatValue:[_sender floatValue]];
}
- (void)takeDoubleValueFrom:(id)_sender {
  [self setDoubleValue:[_sender doubleValue]];
}
- (void)takeBoolValueFrom:(id)_sender {
  [self setBoolValue:[_sender boolValue]];
}

@end

void __link_NSObjectTakeValues(void) {
  __link_NSObjectTakeValues();
}
