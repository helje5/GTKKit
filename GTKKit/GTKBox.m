/*
   GTKBox.m

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

// $Id: GTKBox.m,v 1.12 1998/08/10 00:36:50 helge Exp $

#import "common.h"
#import "GTKBox.h"

@implementation GTKBoxLayoutInfo

static GTKBoxLayoutInfo *defLayout = nil;
static GTKBoxLayoutInfo *noExpandNoFill = nil;
static GTKBoxLayoutInfo *noExpandDoFill = nil;

- (id)initWithPadding:(int)_padding doExpand:(BOOL)_expand doFill:(BOOL)_fill {
  if ((self = [super init])) {
    self->expand  = _expand;
    self->fill    = _fill;
    self->padding = _padding;
  }
  return self;
}

+ (id)defaultLayout {
  if (defLayout == nil) 
    defLayout = [[self alloc] initWithPadding:0 doExpand:YES doFill:YES];
  return defLayout;
}
+ (id)layoutWithNoExpand {
  if (noExpandDoFill == nil)
    noExpandDoFill = [[self alloc] initWithPadding:0 doExpand:NO doFill:YES];
  return noExpandDoFill;
}
+ (id)layoutWithNoExpandAndNoFill {
  if (noExpandNoFill == nil)
    noExpandNoFill = [[self alloc] initWithPadding:0 doExpand:NO doFill:NO];
  return noExpandNoFill;
}

+ (id)layoutWithPadding:(int)_padding doExpand:(BOOL)_expand doFill:(BOOL)_fill {
  return AUTORELEASE([[self alloc] initWithPadding:_padding
                                   doExpand:_expand
                                   doFill:_fill]);
}
+ (id)layoutWithPadding:(int)_padding {
  return AUTORELEASE([[self alloc] initWithPadding:_padding doExpand:YES doFill:YES]);
}

// accessors

- (BOOL)expand {
  return self->expand;
}
- (BOOL)fill {
  return self->fill;
}
- (int)padding {
  return self->padding;
}

// description

- (NSString *)description {
  return [NSString stringWithFormat:@"<BoxLayout: padding=%i fill=%s expand=%s>",
                     [self padding],
                     [self fill] ? "YES" : "NO",
                     [self expand] ? "YES" : "NO"
                   ];
}

@end

@implementation GTKBox

+ (id)horizontalBox {
  return AUTORELEASE([[GTKHorizBox alloc] init]);
}
+ (id)horizontalBoxWithSpacing:(int)_spacing sameSize:(BOOL)_flag {
  return [GTKHorizBox horizontalBoxWithSpacing:_spacing
                      sameSize:_flag];
}

+ (id)verticalBox {
  return AUTORELEASE([[GTKVertBox alloc] init]);
}
+ (id)verticalBoxWithSpacing:(int)_spacing sameSize:(BOOL)_flag {
  return [GTKVertBox verticalBoxWithSpacing:_spacing
                     sameSize:_flag];
}

+ (id)horizontalBoxWithSpacing:(int)_spacing sameSize:(BOOL)_flag
  contents:(GTKWidget *)_first, ... {

  GTKBox *box = nil;
  va_list va;
  
  va_start(va, _first);
  box = [GTKHorizBox horizontalBoxWithSpacing:_spacing sameSize:_flag];
  [box addSubWidgets:_first arguments:va];
  va_end(va);
  return box;
}
+ (id)verticalBoxWithSpacing:(int)_spacing sameSize:(BOOL)_flag
  contents:(GTKWidget *)_first, ... {

  GTKBox *box = nil;
  va_list va;
  
  va_start(va, _first);
  box = [GTKVertBox verticalBoxWithSpacing:_spacing sameSize:_flag];
  [box addSubWidgets:_first arguments:va];
  va_end(va);
  return box;
}

// packing

- (void)_addSubWidgetAtStart:(GTKWidget *)_widget {
  GTKBoxLayoutInfo *info = [_widget layout];

  if (info == nil) {
    NSLog(@"WARNING: no widget layout in %@ for container %@",
          _widget, self);
    info = [GTKBoxLayoutInfo defaultLayout];
  }
  else if (![info isKindOfClass:[GTKBoxLayoutInfo class]]) {
    NSLog(@"WARNING: wrong widget layout(%@) in %@ for container %@",
          info, _widget, self);
    info = [GTKBoxLayoutInfo defaultLayout];
  }
  
  gtk_box_pack_start((GtkBox *)gtkObject, [_widget gtkWidget],
                   [info expand], [info fill], [info padding]);
}
- (void)_addSubWidgetAtEnd:(GTKWidget *)_widget {
  GTKBoxLayoutInfo *info = [_widget layout];

  if (info == nil) {
    NSLog(@"WARNING: no widget layout in %@ for container %@",
          _widget, self);
    info = [GTKBoxLayoutInfo defaultLayout];
  }
  else if (![info isKindOfClass:[GTKBoxLayoutInfo class]]) {
    NSLog(@"WARNING: wrong widget layout(%@) in %@ for container %@",
          info, _widget, self);
    info = [GTKBoxLayoutInfo defaultLayout];
  }
  
  gtk_box_pack_end((GtkBox *)gtkObject, [_widget gtkWidget],
                   [info expand], [info fill], [info padding]);
}

- (void)addSubWidget:(GTKWidget *)_widget {
  [self _addSubWidgetAtStart:_widget]; // add to gtk-widget
  [self _primaryAddSubWidget:_widget]; // add to array of subwidgets
}

// accessors

- (void)setSpacing:(gint16)_spacing {
  gtk_box_set_spacing((GtkBox *)gtkObject, _spacing);
}
- (gint16)spacing {
  return ((GtkBox *)gtkObject)->spacing;
}

- (void)setIsHomogeneous:(BOOL)_flag {
  gtk_box_set_homogeneous((GtkBox *)gtkObject, _flag ? TRUE : FALSE);
}
- (BOOL)isHomogeneous {
  return ((GtkBox *)gtkObject)->homogeneous;
}

// private

- (GtkBox *)gtkBox {
  return (GtkBox *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_box_get_type();
}

- (GList *)gtkChildren {
  return ((GtkBox *)gtkObject)->children;
}

@end

@implementation GTKVertBox

+ (id)verticalBox {
  return AUTORELEASE([[self alloc] initWithSpacing:1 isHomogeneous:NO]);
}
+ (id)verticalBoxWithSpacing:(int)_spacing sameSize:(BOOL)_flag {
  return AUTORELEASE([[self alloc] initWithSpacing:_spacing isHomogeneous:_flag]);
}

- (id)init {
  return [self initWithSpacing:1 isHomogeneous:NO];
}
- (id)initWithSpacing:(int)_spacing isHomogeneous:(BOOL)_flag {
  return [self initWithGtkObject:(GtkObject *)gtk_vbox_new(_flag, _spacing)];
}

// private

- (GtkVBox *)gtkVBox {
  return (GtkVBox *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_vbox_get_type();
}

@end

@implementation GTKHorizBox

+ (id)horizontalBox {
  return AUTORELEASE([[self alloc] initWithSpacing:1 isHomogeneous:NO]);
}
+ (id)horizontalBoxWithSpacing:(int)_spacing sameSize:(BOOL)_flag {
  return AUTORELEASE([[self alloc] initWithSpacing:_spacing isHomogeneous:_flag]);
}

- (id)init {
  return [self initWithSpacing:1 isHomogeneous:NO];
}
- (id)initWithSpacing:(int)_spacing isHomogeneous:(BOOL)_flag {
  return [self initWithGtkObject:(GtkObject *)gtk_hbox_new(_flag, _spacing)];
}

// private

- (GtkHBox *)gtkHBox {
  return (GtkHBox *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_hbox_get_type();
}

@end
