/*
   GTKTableList.m

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

// $Id: GTKTableList.m,v 1.10 1998/08/16 20:50:27 helge Exp $

#import "common.h"
#import "GTKTableList.h"
#import "GTKTableDataSource.h"
#import "GTKObject+Bean.h"


NSString *GTKTableListColumnDidMoveNotification =
  @"GTKTableListColumnDidMoveNotification";
NSString *GTKTableListColumnDidResizeNotification =
  @"GTKTableListColumnDidResizeNotification";
NSString *GTKTableListSelectionDidChangeNotification =
  @"GTKTableListSelectionDidChangeNotification";

@implementation GTKTableList

+ (id)tableListWithWidth:(int)_columnCount {
  return [[[self alloc] initWithWidth:_columnCount] autorelease];
}
+ (id)tableListWithTitles:(NSArray *)_titles {
  return [[[self alloc] initWithTitles:_titles] autorelease];
}

- (id)initWithGtkObject:(GtkObject *)_obj {
  if ((self = [super initWithGtkObject:_obj])) {
    int cnt;
    
    for (cnt = 0; cnt < ((GtkCList *)_obj)->columns; cnt++)
      gtk_clist_set_column_width((GtkCList *)_obj, cnt, 100);

    gtk_clist_set_selection_mode((GtkCList *)_obj, GTK_SELECTION_BROWSE);
  }
  return self;
}

- (id)init {
  return [self initWithWidth:1];
}

- (id)initWithWidth:(int)_columnCount {
  return [self initWithGtkObject:(GtkObject *)gtk_clist_new(_columnCount)];
}

- (id)initWithTitles:(NSArray *)_titles {
  int titleCount = [_titles count];

  self = [self initWithWidth:titleCount];
  if (self) {
    int cnt;
    for (cnt = 0; cnt < titleCount; cnt++) {
      gtk_clist_set_column_title((GtkCList *)gtkObject,
         cnt, (char *)[[_titles objectAtIndex:cnt] cString]);
    }
  }
  return self;
}

- (id)initWithPropertyList:(id)_propertyList {
  // extracts 'columnCount' key
  id colCount = nil;
  id titles   = nil;
  
  NSAssert([_propertyList isKindOfClass:[NSDictionary class]],
           @"invalid property list, need a dictionary");

  colCount = [_propertyList objectForKey:@"columnCount"];
  titles   = RETAIN([_propertyList objectForKey:@"titles"]);

  if (titles != nil) {
    if ([titles count] > [colCount intValue])
      colCount = [NSNumber numberWithInt:[titles count]];
  }
  if ([colCount intValue] <= 0)
    colCount = [NSNumber numberWithInt:1];

  self = [self initWithWidth:[colCount intValue]];
  if (self) {
    _propertyList = [_propertyList mutableCopy];
    [_propertyList removeObjectForKey:@"titles"];
    [_propertyList removeObjectForKey:@"columnCount"];
    [self takeValuesFromDictionary:_propertyList];
    
    if (titles) [self setTitles:titles];

    RELEASE(_propertyList); _propertyList = nil;
  }
  RELEASE(titles); titles = nil;
  return self;
}

- (void)dealloc {
  [self setTarget:nil];
  [self setDataSource:nil];
  [super dealloc];
}

// init widget

- (void)loadGtkObject {
  [super loadGtkObject];
  [self addSelfAsObserverForSignal:@"select_row"];
  [self addSelfAsObserverForSignal:@"unselect_row"];
  [self addSelfAsObserverForSignal:@"click_column"];
}

// running late initialization

- (void)runLateInitialization {
  if (!didRunLateInit) {
    [super runLateInitialization];
    [self setShowsTitles:showsColumnTitles];
  }
}
- (void)storeLateAttributes {
  showsColumnTitles = [self doesShowTitles];
}

// showing

- (void)show {
  [self reloadData];
  [super show];
}
- (void)hide {
  [super hide];
  [self clear:self];
}

// signals

- (void)rowWasSelected:(GTKSignalEvent *)_event {
  // [[_event valueOfArgument:@"0"] intValue]
  
  [self sendAction:action to:target];

  [self selfPostNotification:GTKTableListSelectionDidChangeNotification
        delegateSelector:@selector(tableListSelectionDidChange:)];
}

- (void)rowWasDeselected:(GTKSignalEvent *)_event {
  // int row = [[_event valueOfArgument:@"0"] intValue];
  
  [self sendAction:action to:target];

  [self selfPostNotification:GTKTableListSelectionDidChangeNotification
        delegateSelector:@selector(tableListSelectionDidChange:)];
}

- (void)columnWasClicked:(GTKSignalEvent *)_event {
  // int column = [[_event valueOfArgument:@"0"] intValue];
}

- (void)handleEvent:(GTKSignalEvent *)_event {
  NSString *_signalName = [_event signalName];
  
  if ([_signalName isEqualToString:@"select_row"])
    [self rowWasSelected:_event];
  else if ([_signalName isEqualToString:@"unselect_row"])
    [self rowWasDeselected:_event];
  else if ([_signalName isEqualToString:@"click_column"])
    [self columnWasClicked:_event];
  else
    [super handleEvent:_event];
}

// control

- (void)setTarget:(id)_target {
  ASSIGN(target, _target);
}
- (id)target {
  return target;
}

- (void)setAction:(SEL)_action {
  action = _action;
}
- (SEL)action {
  return action;
}

- (BOOL)sendAction:(SEL)_action to:(id)_target {
  return [GTKApp sendAction:_action to:_target from:self];
}

// accessors

- (void)setBorderStyle:(GtkShadowType)_style {
  gtk_clist_set_border((GtkCList *)gtkObject, _style);
}
- (GtkShadowType)borderStyle {
  return ((GtkCList *)gtkObject)->shadow_type;
}

- (void)setSelectionMode:(GtkSelectionMode)_mode {
  gtk_clist_set_selection_mode((GtkCList *)gtkObject, _mode);
}
- (GtkSelectionMode)selectionMode {
  return ((GtkCList *)gtkObject)->selection_mode;
}

- (void)setShowsTitles:(BOOL)_flag {
  if (didRunLateInit) {
    if (_flag) gtk_clist_column_titles_show((GtkCList *)gtkObject);
    else gtk_clist_column_titles_hide((GtkCList *)gtkObject);
  }
  else {
    showsColumnTitles = _flag;
  }
}
- (BOOL)doesShowTitles {
  if (didRunLateInit)
    return GTK_CLIST_SHOW_TITLES((GtkCList *)gtkObject) ? YES : NO;
  else
    return showsColumnTitles;
}

- (void)setHasActiveTitles:(BOOL)_flag {
  if (_flag) gtk_clist_column_titles_active((GtkCList *)gtkObject);
  else gtk_clist_column_titles_passive((GtkCList *)gtkObject);
}

- (void)setRowHeight:(gint)_height {
  gtk_clist_set_row_height((GtkCList *)gtkObject, _height);
}
- (gint)rowHeight {
  return ((GtkCList *)gtkObject)->row_height;
}

- (void)setDataSource:(id)_object {
  ASSIGN(dataSource, _object);
}
- (id)dataSource {
  return dataSource;
}

// selection

- (void)selectRowAtIndex:(gint)_idx {
  gtk_clist_select_row((GtkCList *)gtkObject, _idx, 0);
  
  [self selfPostNotification:GTKTableListSelectionDidChangeNotification
        delegateSelector:@selector(tableListSelectionDidChange:)];
}
- (void)deselectRowAtIndex:(gint)_idx {
  gtk_clist_unselect_row((GtkCList *)gtkObject, _idx, 0);
  
  [self selfPostNotification:GTKTableListSelectionDidChangeNotification
        delegateSelector:@selector(tableListSelectionDidChange:)];
}

- (NSArray *)selectedRows {
  GtkSelectionMode mode = ((GtkCList *)gtkObject)->selection_mode;
  GList *selection = ((GtkCList *)gtkObject)->selection;

  if (selection == NULL)
    return [NSArray array];
  else if ((mode == GTK_SELECTION_SINGLE) || (mode == GTK_SELECTION_BROWSE)) {
    id idx = [NSNumber numberWithInt:(gint)selection->data];
    return idx ? [NSArray arrayWithObject:idx] : [NSArray array];
  }
  else if (mode == GTK_SELECTION_EXTENDED)
    return nil;
  else {
    NSMutableArray *array = nil;
    int selCount = 0;

    while (selection) {
      selCount++;
      selection = selection->next;
    }

    if (selCount == 0) return [NSArray array];

    array = [NSMutableArray arrayWithCapacity:selCount + 1];
    selection = ((GtkList *)gtkObject)->selection;

    while (selection) {
      [array addObject:[NSNumber numberWithInt:(gint)selection->data]];
      selection = selection->next;
    }

    return array;
  }
}

- (void)selectAll:(id)_sender {
  BOOL didChange;
  
  [self freeze:self];
  {
    int cnt, rowCount = [self numberOfRows];
    
    didChange = (((GtkCList *)gtkObject)->selection != NULL);

    for (cnt = 0; cnt < rowCount; cnt++)
      gtk_clist_select_row((GtkCList *)gtkObject, cnt, 0);
  }
  [self thaw:self];

  if (didChange) {
    [self selfPostNotification:GTKTableListSelectionDidChangeNotification
          delegateSelector:@selector(tableListSelectionDidChange:)];
  }
}
- (void)deselectAll:(id)_sender {
  BOOL didChange;
  [self freeze:self];
  {
    NSArray *selection = [self selectedRows];
    int cnt, selCount = [selection count];

    didChange = (selCount > 0);

    for (cnt = 0; cnt < selCount; cnt++) {
      int rowIdx = [[selection objectAtIndex:cnt] intValue];
      gtk_clist_unselect_row((GtkCList *)gtkObject, rowIdx, 0);
    }
  }
  [self thaw:self];

  if (didChange) {
    [self selfPostNotification:GTKTableListSelectionDidChangeNotification
          delegateSelector:@selector(tableListSelectionDidChange:)];
  }
}

// columns

- (gint)numberOfColumns {
  NSAssert(gtkObject != NULL, @"gtk widget is null");
  return ((GtkCList *)gtkObject)->columns;
}

- (void)setTitle:(NSString *)_title ofColumn:(int)_idx {
  NSAssert(gtkObject != NULL, @"gtk widget is null");
  gtk_clist_set_column_title((GtkCList *)gtkObject,
                             _idx, (char *)[_title cString]);
}
- (void)setWidth:(gint)_width ofColumn:(int)_idx {
  NSAssert(gtkObject != NULL, @"gtk widget is null");
  gtk_clist_set_column_width((GtkCList *)gtkObject, _idx, _width);
}
- (void)setJustification:(GtkJustification)_j ofColumn:(int)_idx {
  NSAssert(gtkObject != NULL, @"gtk widget is null");
  gtk_clist_set_column_justification((GtkCList *)gtkObject, _idx, _j);
}

- (void)setTitle:(NSString *)_title andWidth:(gint)_width ofColumn:(int)_idx {
  [self setTitle:_title ofColumn:_idx];
  [self setWidth:_width ofColumn:_idx];
}

- (void)setTitles:(NSArray *)_titles {
  int cnt, len = [_titles count];
  NSAssert(gtkObject != NULL,                       @"gtk widget is null");
  NSAssert([_titles isKindOfClass:[NSArray class]], @"titles must be an array");

  for (cnt = 0; cnt < len; cnt++) {
    gtk_clist_set_column_title((GtkCList *)gtkObject,
                               cnt, (char *)[[_titles objectAtIndex:cnt] cString]);
  }
}

// rows

- (gint)numberOfRows {
  return ((GtkCList *)gtkObject)->rows;
}

- (void)clear:(id)_sender {
  gtk_clist_clear((GtkCList *)gtkObject);
}

- (BOOL)isRowVisible:(gint)_idx {
  return gtk_clist_row_is_visible((GtkCList *)gtkObject, _idx);
}

// scrolling

- (void)scrollColumnToLeft:(gint)_col {
  gtk_clist_moveto((GtkCList *)gtkObject, -1, _col, 0.0, 0.0);
}
- (void)scrollColumnToMiddle:(gint)_col {
  gtk_clist_moveto((GtkCList *)gtkObject, -1, _col, 0.0, 0.5);
}
- (void)scrollRowToTop:(gint)_row {
  gtk_clist_moveto((GtkCList *)gtkObject, _row, -1, 0.0, 0.0);
}
- (void)scrollRowToMiddle:(gint)_row {
  gtk_clist_moveto((GtkCList *)gtkObject, _row, -1, 0.5, 0.0);
}

- (void)setHorizontalPolicy:(GtkPolicyType)_policy {
  gtk_clist_set_policy((GtkCList *)gtkObject,
                       ((GtkCList *)gtkObject)->vscrollbar_policy,
                       _policy);
}
- (GtkPolicyType)horizontalPolicy {
  return ((GtkCList *)gtkObject)->hscrollbar_policy;
}

- (void)setVerticalPolicy:(GtkPolicyType)_policy {
  gtk_clist_set_policy((GtkCList *)gtkObject,
                       _policy,
                       ((GtkCList *)gtkObject)->hscrollbar_policy);
}
- (GtkPolicyType)verticalPolicy {
  return ((GtkCList *)gtkObject)->vscrollbar_policy;
}

// loading

- (void)reloadData {
  NSAutoreleasePool *pool = [NSAutoreleasePool new];
  {
    NSException *exception = nil;
    
    gtk_clist_freeze((GtkCList *)gtkObject);
    gtk_clist_clear((GtkCList *)gtkObject);
    
    NS_DURING {
      IMP getMethod     = NULL;
      int columnCount = [self numberOfColumns];
      int rowCount    = [dataSource numberOfRowsInTableList:self];
      int row;

      getMethod = [dataSource methodForSelector:
                     @selector(tableList:objectValueForTableColumn:row:)];

      for (row = 0; row < rowCount; row++) {
        id   objValues[columnCount];
        char *strPtr[columnCount];
        int  column;

        for (column = 0; column < columnCount; column++) {
          id value = nil;

          value = getMethod(dataSource,
                            @selector(tableList:objectValueForTableColumn:row:),
                            self,
                            column,
                            row);

          if (![value isKindOfClass:[NSString class]]) {
            value = AUTORELEASE(RETAIN([value stringValue]));
          }
          
          objValues[column] = value;
          strPtr[column]    = (char *)[objValues[column] cString];
        }

        gtk_clist_append((GtkCList *)gtkObject, strPtr);
      }
    }
    NS_HANDLER {
      exception = [localException retain];
    }
    NS_ENDHANDLER;
    
    gtk_clist_thaw((GtkCList *)gtkObject);

    if (exception) {
      [exception autorelease];
      [exception raise];
    }
  }
  
  [pool release]; pool = nil;
}

// actions

- (void)reload:(id)_sender {
  [self reloadData];
}

- (void)showTitles:(id)_sender {
  [self setShowsTitles:YES];
}
- (void)hideTitles:(id)_sender {
  [self setShowsTitles:NO];
}

- (void)freeze:(id)_sender {
  gtk_clist_freeze((GtkCList *)gtkObject);
}
- (void)thaw:(id)_sender {
  gtk_clist_thaw((GtkCList *)gtkObject);
}

// private

- (GtkCList *)gtkCList {
  return (GtkCList *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_clist_get_type();
}

- (gint)rowCenterOffset {
  return ((GtkCList *)gtkObject)->row_center_offset;
}
- (GList *)rowList {
  return ((GtkCList *)gtkObject)->row_list;
}

- (GtkWidget *)gtkHorizScrollbar {
  return ((GtkCList *)gtkObject)->hscrollbar;
}
- (GtkWidget *)gtkVertScrollbar {
  return ((GtkCList *)gtkObject)->vscrollbar;
}

- (void)getRowAndColumnAtPoint:(gint)_x:(gint)_y
  row:(gint *)_row
  column:(gint *)_column {

  gtk_clist_get_selection_info((GtkCList *)gtkObject,
                               _x, _y, _row, _column);
}

@end
