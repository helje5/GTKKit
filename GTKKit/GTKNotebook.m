/*
   GTKNotebook.m

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

// $Id: GTKNotebook.m,v 1.9 1998/08/17 00:01:32 helge Exp $

#import "common.h"
#import "GTKNotebook.h"
#import "GTKLabel.h"
#import "GTKObject+Bean.h"

@implementation GTKNotebook

+ (id)notebook {
  return [[[self alloc] init] autorelease];
}

- (id)initWithGtkObject:(GtkObject *)_object {
  if ((self = [super initWithGtkObject:(GtkObject *)gtk_notebook_new()])) {
    labels = [[NSMutableArray alloc] initWithCapacity:16];
  }
  return self;
}
- (id)init {
  return [self initWithGtkObject:(GtkObject *)gtk_notebook_new()];
}

- (id)initWithPropertyList:(id)_propertyList { // extracts 'labels' key
  NSAssert([_propertyList isKindOfClass:[NSDictionary class]],
           @"invalid property list, need a dictionary");
  
  if ((self = [self init])) {
    id plabels = [_propertyList objectForKey:@"labels"];

    if (plabels) {
      int cnt, labelCount = [plabels count];
      
      NSAssert([plabels isKindOfClass:[NSArray class]],
               @"invalid value of property 'labels', requires NSArray");
      _propertyList = [_propertyList mutableCopy];
      [_propertyList removeObjectForKey:@"labels"];
      [self takeValuesFromDictionary:_propertyList];
      RELEASE(_propertyList); _propertyList = nil;

      for (cnt = 0; cnt < labelCount; cnt++) {
        id label = [plabels objectAtIndex:cnt];

        if ([label isKindOfClass:[GTKWidget class]])
          [self->labels addObject:label];
        else
          [self->labels addObject:[GTKLabel labelWithTitle:label]];
      }
    }
    else
      [self takeValuesFromDictionary:_propertyList];
  }
  return self;
}

#if !LIB_FOUNDATION_BOEHM_GC
- (void)dealloc {
  RELEASE(labels); labels = nil;
  [super dealloc];
}
#endif

// properties

- (void)setTabPosition:(GtkPositionType)_pos {
  gtk_notebook_set_tab_pos((GtkNotebook *)gtkObject, _pos);
}
- (GtkPositionType)tabPosition {
  return ((GtkNotebook *)gtkObject)->show_tabs;
}

- (void)setTabsAreVisible:(BOOL)_flag {
  gtk_notebook_set_show_tabs((GtkNotebook *)gtkObject, _flag ? TRUE : FALSE);
}
- (BOOL)tabsAreVisible {
  return ((GtkNotebook *)gtkObject)->show_tabs;
}

- (void)setShowsBorder:(BOOL)_flag {
  gtk_notebook_set_show_border((GtkNotebook *)gtkObject, _flag ? TRUE : FALSE);
}
- (BOOL)doesShowBorder {
  return ((GtkNotebook *)gtkObject)->show_border;
}

// add pages

- (void)addPage:(GTKWidget *)_page label:(GTKWidget *)_label {
  NSAssert(gtkObject != NULL, @"gtk widget is null");
  NSAssert(_page,             @"page widget is nil");

  if ([self->labels count] <= [self->subWidgets count]) {
    if (_label == nil) {
      NSLog(@"WARNING(%s): label is nil for page %@", __PRETTY_FUNCTION__, _page);
      _label = [GTKLabel labelWithTitle:[NSString stringWithFormat:@"Page %i",
                                                    [self->labels count]]];
    }
  }
  else {
    if (_label == nil)
      _label = [labels objectAtIndex:[self->subWidgets count]];
  }
  
  gtk_notebook_append_page((GtkNotebook *)gtkObject,
                           [_page  gtkWidget],
                           [_label gtkWidget]);
  
  [self _primaryAddSubWidget:_page];

  if ([self->labels count] < [self->subWidgets count])
    [labels addObject:_label];
  else {
    [labels replaceObjectAtIndex:([self->subWidgets count] - 1)
            withObject:_label];
  }
}
- (void)addPage:(GTKWidget *)_page title:(NSString *)_title {
  [self addPage:_page label:[GTKLabel labelWithTitle:_title]];
}

- (void)insertPage:(GTKWidget *)_page label:(GTKWidget *)_label atIndex:(gint)_idx {
  NSAssert(gtkObject != NULL, @"gtk widget is null");
  NSAssert(_page,             @"page widget is nil");
  NSAssert(_label,            @"label widget is nil");
  
  gtk_notebook_insert_page((GtkNotebook *)gtkObject,
                           [_page  gtkWidget],
                           [_label gtkWidget],
                           _idx);
  
  [self _primaryInsertSubWidget:_page atIndex:_idx];
  [labels insertObject:_label atIndex:_idx];
}
- (void)insertPage:(GTKWidget *)_page title:(NSString *)_title atIndex:(gint)_idx {
  [self insertPage:_page
        label:[GTKLabel labelWithTitle:_title]
        atIndex:_idx];
}

- (void)removePageAtIndex:(gint)_idx {
  [[subWidgets objectAtIndex:_idx] setSuperWidget:nil];
  gtk_notebook_remove_page((GtkNotebook *)gtkObject, _idx);
  [subWidgets removeObjectAtIndex:_idx];
  [labels     removeObjectAtIndex:_idx];
}
- (void)removePage:(GTKWidget *)_page {
  [self removePageAtIndex:[subWidgets indexOfObject:_page]];
}

- (void)showPageAtIndex:(gint)_idx {
  gtk_notebook_set_page((GtkNotebook *)gtkObject, _idx);
}
- (void)showPage:(GTKWidget *)_page {
  [self showPageAtIndex:[subWidgets indexOfObject:_page]];
}

- (gint)indexOfCurrentPage {
  return gtk_notebook_current_page((GtkNotebook *)gtkObject);
}
- (GTKWidget *)currentPage {
  return [subWidgets objectAtIndex:[self indexOfCurrentPage]];
}

// container support

- (void)addSubWidget:(GTKWidget *)_widget {
  [self addPage:_widget label:nil];
}
- (void)removeSubWidget:(GTKWidget *)_widget {
  [self removePage:_widget];
}

// actions

- (void)nextPage:(id)sender {
  gtk_notebook_next_page((GtkNotebook *)gtkObject);
}
- (void)previousPage:(id)sender {
  gtk_notebook_prev_page((GtkNotebook *)gtkObject);
}

// private

- (GtkNotebook *)gtkNotebook {
  return (GtkNotebook *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_notebook_get_type();
}

- (BOOL)doesNeedTimer {
  return ((GtkNotebook *)gtkObject)->need_timer;
}
- (BOOL)isScrollable {
  return ((GtkNotebook *)gtkObject)->scrollable;
}
- (guint32)notebookTimer {
  return ((GtkNotebook *)gtkObject)->timer;
}
- (gint16)tabBorder {
  return ((GtkNotebook *)gtkObject)->tab_border;
}

// description

- (NSString *)description {
  return [NSString stringWithFormat:
                     @"<%s[0x%08X] %@ labels=%@ isScrollable=%s currentPage=%i "
                     @"tabPosition=%i tabsAreVisible=%s showsBorder=%s>",
                     [[self class] name], gtkObject,
                     [self frameDescription],
                     self->labels,
                     [self isScrollable] ? "YES" : "NO",
                     [self indexOfCurrentPage],
                     [self tabPosition],
                     [self tabsAreVisible] ? "YES" : "NO",
                     [self doesShowBorder] ? "YES" : "NO"
                   ];
}

@end
