// $Id: TableDataSource.m,v 1.1 1998/08/16 18:54:18 helge Exp $

#import <Foundation/Foundation.h>
#import <GTKKit/GTKKit.h>
#import "TableDataSource.h"

@implementation TableDataSource

- (id)init {
  if ((self = [super init])) {
    int cnt;

    data = [[NSMutableArray alloc] initWithCapacity:101];
    for (cnt = 0; cnt < 100; cnt++) {
      [data addObject:[NSString stringWithFormat:@"Entry %i", cnt]];
    }
  }
  return self;
}
- (void)dealloc {
  RELEASE(data); data = nil;
  [super dealloc];
}

- (int)numberOfRowsInTableList:(GTKTableList *)_tableList {
  return [data count];
}

- (id)tableList:(GTKTableList *)_tableList
  objectValueForTableColumn:(int)_columnIdx
  row:(int)_rowIdx {

  return [data objectAtIndex:_rowIdx];
}

@end
