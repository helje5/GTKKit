/*
   GTKHandleBox.m

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

// $Id: GTKHandleBox.m,v 1.5 1998/07/13 10:55:32 helge Exp $

#import "GTKKit.h"
#import "GTKHandleBox.h"


@implementation GTKHandleBox

+ (id)handleBox {
   return AUTORELEASE([[self alloc] init]);
}

- (void)connect {
  if ([self respondsToSelector:@selector(childAttached:)])
    [self addSelfAsObserverForSignal:@"child_attached" 
	  fromGtkObject:gtkObject]; 
  if ([self respondsToSelector:@selector(childDetached:)])
    [self addSelfAsObserverForSignal:@"child_detached" 
	  fromGtkObject:gtkObject];

  // make the handle work as desired
  ((GtkHandleBox*)gtkObject)->shrink_on_detach=0;
  [self show];
}

- (void)childAttached:(GTKSignalEvent *)_event {
  // NSLog(@"childAttached");
}

- (void)childDetached:(GTKSignalEvent *)_event {
  // NSLog(@"childDetached");
}

- (id)init {
  if ((self = [super initWithGtkObject:(GtkObject *)gtk_handle_box_new()])) {
    [self connect];
  }
  return self;
}

- (void)handleEvent:(GTKSignalEvent *)_event {
  if ([[_event signalName] isEqualToString:@"child_detached"])   
    [self childDetached:_event ];
  else if ([[_event signalName] isEqualToString:@"child_attached"])
    [self childAttached:_event];
  else
    [super handleEvent:_event];
}

@end
