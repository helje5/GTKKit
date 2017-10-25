/*
   GTKEntry.h

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

// $Id: GTKEntry.h,v 1.1 1998/07/09 06:07:20 helge Exp $

#include <gtk/gtkentry.h>
#import <GTKKit/GTKEditable.h>
#import <GTKKit/GTKFormatter.h>

extern NSString *NSControlTextDidChangeNotification;
extern NSString *NSControlTextDidEndEditingNotification;

/*
  The Entry widget allows text to be typed and displayed
  in a single line text box.
*/

@interface GTKEntry : GTKEditable
{
  id<NSObject,GTKFormatter> formatter;
  id delegate;
}

+ (id)textEntry;
+ (id)textEntryWithMaxLength:(guint16)_maxLen;
- (id)initWithMaxLength:(guint16)_maxLen;

// properties

- (void)setFormatter:(id<NSObject,GTKFormatter>)_formatter;
- (id<NSObject,GTKFormatter>)formatter;

- (void)setDelegate:(id)_delegate;
- (id)delegate;

- (void)setMaxLength:(guint16)_maxLen;
- (guint16)maxLength;

- (void)setEditable:(BOOL)_flag;

- (void)setTextIsHidden:(BOOL)_flag;
- (BOOL)isTextHidden;

// position

- (void)setPoint:(gint)_position;
// -point; is inherited from GTKEditable

- (guint16)textLength;

// selection

- (void)setSelectedRange:(NSRange)_range;
- (void)selectText:(id)sender;

// modifiying

- (void)appendString:(NSString *)_value;
- (void)prependString:(NSString *)_value;

// values

- (void)setStringValue:(NSString *)_value;
- (NSString *)stringValue;

// private

- (GtkEntry *)gtkEntry;
+ (guint)typeIdentifier;

@end

@interface NSObject(GTKEntryDelegate)

- (void)textDidChange:(NSNotification *)_notification;
- (void)textDidEndEditing:(NSNotification *)_notification;

- (BOOL)entry:(GTKEntry *)_entry
  didFailToFormatString:(NSString *)_string
  errorDescription:(NSString *)_error;

@end
