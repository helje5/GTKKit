/*
   GTKHandle.h

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

// $Id: GTKHandle.h,v 1.2 1998/07/09 06:49:13 helge Exp $


#include <Foundation/NSGeometry.h>
#import <GTKKit/GTKObject.h>

@interface GTKHandle : GTKFixed
{
  GTKContainer *widget;
  BOOL bound;
  int  wxPos,wyPos;  
  int  mxPos,myPos;
}
+ (id)handle;
+ (id)handleHorizontal;
+ (id)handleVertical;

- initHorizontal;
- initVertical;

- (void)setMotionToWidget:(GTKContainer *)_widget;
- (void)boundToParentSize;

@end

