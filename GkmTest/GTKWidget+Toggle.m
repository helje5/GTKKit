// $Id: GTKWidget+Toggle.m,v 1.1 1998/08/09 18:04:20 helge Exp $

#import <Foundation/Foundation.h>
#import <GTKKit/GTKKit.h>

@implementation GTKWidget(ToggleHideShow)

- (void)toggleHideShow:(id)_sender {
  // if the widget is visible, hide otherwise show
  if (GTK_WIDGET_VISIBLE(gtkObject)) [self hide:_sender];
  else [self show:_sender];
}

@end
