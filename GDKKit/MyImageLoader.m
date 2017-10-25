/*
   MyImageLoader.m


   This file is part of GDKKit.

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

// $Id: MyImageLoader.m,v 1.2 1998/08/06 17:23:01 helge Exp $

#import "GDKKit.h"
#import "MyImageLoader.h"

@implementation MyImageLoader

// cache management. This must be done because of an bug in
// gdk_imlib. After reading an image more than once, gdk_imlib
// returns no correct bitmask.

NSMutableDictionary *_cachedImages=nil;

- (NSMutableDictionary *)_allocateStorage {
  return [[NSMutableDictionary alloc] initWithCapacity:42];
}

- (void)_addImage:(MyImageLoader *)aImage :(NSString *)aName{
  if (_cachedImages == nil) _cachedImages = [self _allocateStorage];
  [_cachedImages setObject:aImage forKey:aName];
}

- (MyImageLoader*)_inCache:(NSString *)aName {
  if (!_cachedImages) return nil;
  return [_cachedImages objectForKey:aName];
}

// ------


+ (id)imageFromFile:(NSString *)_name  {
  return [[[self alloc] initImageFromFile:_name] autorelease];
}

+ (id)imageFromData:(char **)_data  {
  return [[[self alloc] initImageFromData:_data] autorelease];
}

- (id)initImageFromFile:(NSString *)_name  {
  MyImageLoader *aImage;
  self = [super init];
  if (! (aImage=[self _inCache:_name]) ) { 
    gdk_imlib_load_file_to_pixmap((char *)[_name cString],&mypixmap,&mymask);
    [self _addImage:self :_name];
  }
  else {
    //    NSLog(@"read from cache %@",_name);
    mypixmap = [aImage pixMap];
    mymask   = [aImage bitMap];
  } 
  return self;
}

- (id)initImageFromData:(char **)_data  {
  self = [super init];
  gdk_imlib_data_to_pixmap(_data, &mypixmap, &mymask );
  return self;
}

- (GdkBitmap *)bitMap {
  return mymask;
} 
- (GdkPixmap *)pixMap {
  return mypixmap;
}


@end
