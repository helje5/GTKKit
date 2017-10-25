/*
   NSObject+TakeValues.h

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

// $Id: NSObject+TakeValues.h,v 1.1 1998/07/09 06:07:52 helge Exp $

#import <Foundation/NSObject.h>

@class NSString;

@interface NSObject(GTKValueObject)

- (void)setStringValue:(NSString *)_string;
- (NSString *)stringValue;
- (void)setObjectValue:(id)_object;
- (id)objectValue;

- (void)setIntValue:(int)_value;
- (int)intValue;
- (void)setFloatValue:(float)_value;
- (float)floatValue;
- (void)setDoubleValue:(double)_value;
- (double)doubleValue;
- (void)setBoolValue:(BOOL)_value;
- (BOOL)boolValue;

@end

@interface NSObject(GTKTakeValues)

- (void)takeStringValueFrom:(id)_sender;
- (void)takeObjectValueFrom:(id)_sender;
- (void)takeIntValueFrom:(id)_sender;
- (void)takeFloatValueFrom:(id)_sender;
- (void)takeDoubleValueFrom:(id)_sender;
- (void)takeBoolValueFrom:(id)_sender;

@end
