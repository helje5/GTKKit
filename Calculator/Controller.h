// $Id: Controller.h,v 1.1 1998/08/16 14:58:09 helge Exp $

#import <Foundation/NSObject.h>

@class GTKEntry, GTKWindow;

@interface Controller : NSObject
{
  GTKWindow *window;
  GTKEntry  *display;

  double storedValue;
  int    storedOperation;
  BOOL   resetOnNextDigit;
}

- (void)digitPressed:(id)_sender;

@end
