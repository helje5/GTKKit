/*
   MyImageLoader.h


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

// $Id: MyImageLoader.h,v 1.2 1998/08/06 17:23:01 helge Exp $

#include <gdk_imlib.h>

@interface MyImageLoader : NSObject
{
  GdkBitmap *mymask;
  GdkPixmap *mypixmap;
}

+ (id)imageFromFile:(NSString *)_name;
+ (id)imageFromData:(char **)_data;

- (id)initImageFromFile:(NSString *)_name;
- (id)initImageFromData:(char **)_data;

- (NSMutableDictionary *)_allocateStorage;
- (void)_addImage:(MyImageLoader *)aImage :(NSString *)aName;
- (MyImageLoader *)_inCache:(NSString *)aName;

- (GdkBitmap *)bitMap;
- (GdkPixmap *)pixMap;

@end
