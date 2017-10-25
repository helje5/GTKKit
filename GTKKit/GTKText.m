/*
   GTKText.m

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

// $Id: GTKText.m,v 1.3 1998/07/10 12:18:30 helge Exp $

#import "common.h"
#import "GTKText.h"
#import "GTKAdjustment.h"

@implementation GTKText

+ (id)text {
  return [[[self alloc] init] autorelease];
}
+ (id)textWithAdjustment:(GTKAdjustment *)_horiz:(GTKAdjustment *)_vert {
  return [[[self alloc] initWithAdjustment:_horiz:_vert] autorelease];
}

- (id)init {
  return [self initWithAdjustment:nil:nil];
}
- (id)initWithGtkObject:(GtkObject *)_obj {
  if ((self = [super initWithGtkObject:_obj])) {
    lateContent = [[NSMutableString alloc] initWithCapacity:256];
    [GTKGetObject(((GtkText *)_obj)->hadj) retain];
    [GTKGetObject(((GtkText *)_obj)->vadj) retain];
  }
  return self;
}
- (id)initWithAdjustment:(GTKAdjustment *)_horiz:(GTKAdjustment *)_vert {
  GtkObject *obj = (GtkObject *)gtk_text_new([_horiz gtkAdjustment],
                                             [_vert  gtkAdjustment]);
  return [self initWithGtkObject:obj];
}

- (void)dealloc {
  if (gtkObject) {
    GTKAdjustment *horiz = GTKGetObject(((GtkText *)gtkObject)->hadj);
    GTKAdjustment *vert  = GTKGetObject(((GtkText *)gtkObject)->vadj);

    [horiz release]; horiz = nil;
    [vert  release]; vert  = nil;

    [lateContent release]; lateContent = nil;
  }
  [super dealloc];
}

// running late initialization

- (void)runLateInitialization {
  if (!didRunLateInit) {
    [super runLateInitialization];
    if (lateContent) {
      [self setStringValue:lateContent];
      [lateContent release];
      lateContent = nil;
    }
  }
}
- (void)storeLateAttributes {
  [lateContent release]; lateContent = nil;
  lateContent = [[NSMutableString alloc]
                                  initWithCapacity:[self textLength] + 1];
  [lateContent appendString:[self stringValue]];
}

// text properties

- (guint)textCapacity {
  return ((GtkText *)gtkObject)->text_len;
}

- (guint)gapPosition {
  return ((GtkText *)gtkObject)->gap_position;
}
- (guint)gapSize {
  return ((GtkText *)gtkObject)->gap_size;
}

- (guint)indexOfLastCharacter {
  if (didRunLateInit) return ((GtkText *)gtkObject)->text_end;
  else return ([lateContent cStringLength] - 1);
}
- (guint)indexOfFirstVisibleLine {
  return ((GtkText *)gtkObject)->first_line_start_index;
}
- (guint)pixelsCutOfTopLine {
  return ((GtkText *)gtkObject)->first_cut_pixels;
}
- (guint)firstHorizontalPixel {
  return ((GtkText *)gtkObject)->first_onscreen_hor_pixel;
}
- (guint)firstVerticalPixel {
  return ((GtkText *)gtkObject)->first_onscreen_ver_pixel;
}

- (gint)horizontalCursorPosition {
  return ((GtkText *)gtkObject)->cursor_pos_x;
}
- (gint)verticalCursorPosition {
  return ((GtkText *)gtkObject)->cursor_pos_y;
}
- (gint)virtualHorizontalPosition {
  return ((GtkText *)gtkObject)->cursor_virtual_x;
}

- (NSArray *)tabulatorStops {
  return nil;
}
- (gint)defaultTabulatorWidth {
  return ((GtkText *)gtkObject)->default_tab_width;
}

// properties

- (void)setEditable:(BOOL)_flag {
  gtk_text_set_editable((GtkText *)gtkObject, _flag);
}

- (BOOL)hasCursor {
  return ((GtkText *)gtkObject)->has_cursor;
}
- (BOOL)isLineWrappingEnabled {
  return ((GtkText *)gtkObject)->line_wrap;
}

// selection

- (void)selectAll:(id)sender {
  NSRange range;
  range.location = 1;
  range.length   = [self textLength];
  [self setSelectedRange:range];
}

// adjustments

- (void)setAdjustments:(GTKAdjustment *)_horiz:(GTKAdjustment *)_vert {
  GTKAdjustment *horiz = [self horizontalAdjustment];
  GTKAdjustment *vert  = [self verticalAdjustment];

  gtk_text_set_adjustments((GtkText *)gtkObject,
                           [_horiz gtkAdjustment],
                           [_vert  gtkAdjustment]);
  [_horiz retain];
  [_vert  retain];
  [horiz  release];
  [vert   release];
}

- (GTKAdjustment *)horizontalAdjustment {
  return (GTKAdjustment *)GTKGetObject(((GtkText *)gtkObject)->hadj);
}
- (GTKAdjustment *)verticalAdjustment {
  return (GTKAdjustment *)GTKGetObject(((GtkText *)gtkObject)->vadj);
}

// operations

- (void)freeze {
  gtk_text_freeze((GtkText *)gtkObject);
}
- (void)thaw {
  gtk_text_thaw((GtkText *)gtkObject);
}

// point

- (void)setPoint:(guint)_idx {
  if (_idx > [self textLength]) {
#if LIB_FOUNDATION_LIBRARY
    THROW([[RangeException alloc] initWithReason:@"setPoint: in GTKText"
                                  size:[self textLength]
                                  index:_idx]);
#else
    // should throw exception
    return;
#endif
  }
  gtk_text_set_point((GtkText *)gtkObject, _idx);
}
- (guint)point {
  return gtk_text_get_point((GtkText *)gtkObject);
}

- (void)movePointToStart {
  [self setPoint:0];
}
- (void)movePointToEnd {
  [self setPoint:[self textLength]];
}

- (guint)textLength {
  return gtk_text_get_length((GtkText *)gtkObject);
}

// modifying

- (gint)deleteLeft:(guint)_numChars {
  return gtk_text_backward_delete((GtkText *)gtkObject, _numChars);
}
- (gint)deleteRight:(guint)_numChars {
  return gtk_text_forward_delete((GtkText *)gtkObject, _numChars);
}
- (void)deleteAll {
  [self movePointToStart];
  [self deleteRight:[self textLength]];
}

- (void)insertStringAtPoint:(NSString *)_value {
  if (didRunLateInit) {
    gtk_text_insert((GtkText *)gtkObject,
                    NULL, NULL, NULL, // font, foreColor, backColor
                    [_value cString],
                    [_value cStringLength]);
  }
  else {
    [lateContent insertString:_value atIndex:[self point]];
  }
}
- (void)setPoint:(guint)_idx andInsertString:(NSString *)_value {
  [self setPoint:_idx];
  [self insertStringAtPoint:_value];
}

- (void)appendString:(NSString *)_value {
  guint _oldPoint = [self point];
  [self movePointToEnd];
  [self insertStringAtPoint:_value];
  [self setPoint:_oldPoint];
}

- (void)setString:(NSString *)_value {
  [self setStringValue:_value];
}

// values

- (void)setStringValue:(NSString *)_value {
  [self deleteAll];
  [self appendString:_value];
}
- (NSString *)stringValue {
  return [NSString stringWithCString:((GtkText *)gtkObject)->text
                   length:[self textLength]];
}

// private

- (GtkText *)gtkText {
  return (GtkText *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_text_get_type();
}

@end
