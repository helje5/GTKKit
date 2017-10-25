/*
   GTKEntry.m

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

// $Id: GTKEntry.m,v 1.4 1998/08/05 19:08:57 helge Exp $

#import "common.h"
#import "GTKEntry.h"

NSString *NSControlTextDidChangeNotification =
  @"NSControlTextDidChangeNotification";
NSString *NSControlTextDidEndEditingNotification =
  @"NSControlTextDidEndEditingNotification";

@implementation GTKEntry

+ (id)textEntry {
  return [[[self alloc] initWithMaxLength:256] autorelease];
}
+ (id)textEntryWithMaxLength:(guint16)_maxLen {
  return [[[self alloc] initWithMaxLength:256] autorelease];
}

- (id)initWithMaxLength:(guint16)_maxLen {
  GtkObject *obj = (GtkObject *)gtk_entry_new_with_max_length(_maxLen);
  return [self initWithGtkObject:obj];
}

// events

- (void)editableWasActivated {
  [super editableWasActivated];
  
  [self selfPostNotification:NSControlTextDidEndEditingNotification
        delegateSelector:@selector(textDidEndEditing:)];
}

- (void)editableWasChanged {
  [super editableWasChanged];
  
  [self selfPostNotification:NSControlTextDidChangeNotification
        delegateSelector:@selector(textDidChange:)];
}

// properties

- (void)setFormatter:(id<NSObject,GTKFormatter>)_formatter {
  ASSIGN(formatter, _formatter);
}
- (id<NSObject,GTKFormatter>)formatter {
  return formatter;
}

- (void)setDelegate:(id)_delegate {
  ASSIGN(delegate, _delegate);
}
- (id)delegate {
  return delegate;
}

- (void)setMaxLength:(guint16)_maxLen {
  // gtk_entry_set_max_length((GtkEntry *)gtkObject, _maxLen);
  ((GtkEntry *)gtkObject)->text_max_length = _maxLen;
}
- (guint16)maxLength {
  return ((GtkEntry *)gtkObject)->text_max_length;
}

- (void)setEditable:(BOOL)_flag {
  gtk_entry_set_editable((GtkEntry *)gtkObject, _flag);
}

- (void)setTextIsHidden:(BOOL)_flag {
  gtk_entry_set_visibility((GtkEntry *)gtkObject, _flag ? FALSE : TRUE);
}
- (BOOL)isTextHidden {
  return (((GtkEntry *)gtkObject)->visible) ? NO : YES;
}

// position

- (void)setPoint:(gint)_position {
  gtk_entry_set_position((GtkEntry *)gtkObject, _position);
}
- (guint16)textLength {
  return ((GtkEntry *)gtkObject)->text_length;
}

// selection

- (void)setSelectedRange:(NSRange)_range {
  gtk_entry_select_region((GtkEntry *)gtkObject,
                          _range.location, _range.location + _range.length);
}
- (void)selectText:(id)sender {
  NSRange range;
  range.location = 0;
  range.length   = [self textLength];
  if (range.length > 0) [self setSelectedRange:range];
}

// modifiying

- (void)appendString:(NSString *)_value {
  gtk_entry_append_text((GtkEntry *)gtkObject, [_value cString]);
}
- (void)prependString:(NSString *)_value {
  gtk_entry_prepend_text((GtkEntry *)gtkObject, [_value cString]);
}

// values

- (void)setStringValue:(NSString *)_value {
  gtk_entry_set_text((GtkEntry *)gtkObject, [_value cString]);
}
- (NSString *)stringValue {
  gchar *value = gtk_entry_get_text((GtkEntry *)gtkObject);
  return [NSString stringWithCString:value];
}

- (void)setObjectValue:(id)_object {
  NSString *stringValue;

  stringValue = (formatter)
    ? [formatter stringForObjectValue:_object]
    : [_object description];
  
  [self setStringValue:stringValue];
}
- (id)objectValue {
  NSString *stringValue = [self stringValue];
  
  if (formatter) {
    BOOL     result;
    id       obj    = nil;
    NSString *error = nil;

    result = [formatter getObjectValue:&obj
                        forString:stringValue
                        errorDescription:&error];
    if (result) {
      return obj;
    }
    else {
      if ([delegate respondsToSelector:
             @selector(entry:didFailToFormatString:errorDescription:)]) {
        result = [delegate entry:self
                           didFailToFormatString:stringValue
                           errorDescription:error];
        return result ? stringValue : nil;
      }
      else {
        return nil;
      }
    }
  }
  else {
    return stringValue;
  }
}

// private

- (GtkEntry *)gtkEntry {
  return (GtkEntry *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_entry_get_type();
}

@end
