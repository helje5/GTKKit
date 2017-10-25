/*
   MyController.m

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

// $Id: MyController.m,v 1.1 1998/07/09 06:18:26 helge Exp $

#import <GTKKit/GTKKit.h>
#import "MyController.h"

@implementation MyController

- (id)init {
  if ((self = [super init])) {
    fileSel = [[GTKFileSelection alloc] initWithTitle:@"Open File .."];
    [fileSel setFilename:@"/etc"];
    [GTKApp addWindow:fileSel];
  } 
  return self;
}
- (void)dealloc {
  [GTKApp removeWindow:dialog];
  [GTKApp removeWindow:fileSel];
  [dialog  release]; dialog  = nil;
  [fileSel release]; fileSel = nil;
  [super dealloc];
}

// dialog

- (void)showDialog:(id)sender {
  [dialog orderFront:self];
}
- (void)hideDialog:(id)sender {
  [dialog orderOut:self];
}

// file selector

- (void)fileSelOk:(id)sender {
  NSLog(@"controller got file: %@", [sender filename]);
  [self hideFileSelector:self];
}

- (void)showFileSelector:(id)sender {
  [fileSel setTarget:self];
  [fileSel setOkAction:@selector(fileSelOk:)];
  [fileSel setCancelAction:@selector(hideFileSelector:)];
  [fileSel orderFront:self];
}
- (void)hideFileSelector:(id)sender {
  [fileSel orderOut:self];
}

// list

- (void)listChanged:(id)sender {
  id sel = [sender selectedItems];
  if ([sel count] == 1) sel = [sel lastObject];
  else if ([sel count] == 0) sel = @"nothing selected";
  NSLog(@"list was modified, selection is %@", sel);
}

// table list

- (void)tableListChanged:(id)sender {
  id sel = [sender selectedRows];
  if ([sel count] == 1) sel = [sel lastObject];
  else if ([sel count] == 0) sel = @"nothing selected";
  NSLog(@"table list was modified, selection is %@", sel);
}

- (int)numberOfRowsInTableList:(GTKTableList *)_tableList {
  return 100;
}

- (id)tableList:(GTKTableList *)_tableList
  objectValueForTableColumn:(int)_columnIdx
  row:(int)_rowIdx {

  return [NSString stringWithFormat:@"row=%i col=%i", _rowIdx, _columnIdx];
}
@end
