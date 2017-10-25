// $Id: Controller.m,v 1.1 1998/08/16 14:58:09 helge Exp $

#import <Foundation/Foundation.h>
#import <GTKKit/GTKKit.h>
#import "Controller.h"

@implementation Controller

- (id)init {
  [super init];

  [[NSNotificationCenter defaultCenter]
                         addObserver:self
                         selector:@selector(applicationDidFinishLaunching:)
                         name:NSApplicationDidFinishLaunchingNotification
                         object:nil];
  
  return self;
}

- (void)dealloc {
  RELEASE(display); display = nil;
  RELEASE(window);  window  = nil;
  [super dealloc];
}

// operations

- (void)addDigit:(int)_digit {
  NSString *value = [display stringValue];

  if ((value == nil) || [value isEqualToString:@"0"] || self->resetOnNextDigit) {
    if (_digit == 10)
      [display setStringValue:@"0."];
    else
      [display setIntValue:_digit];
    self->resetOnNextDigit = NO;
  }
  else {
    if (_digit == 10)
      [display setStringValue:[value stringByAppendingString:@"."]];
    else
      [display setStringValue:[NSString stringWithFormat:@"%@%i", value, _digit]];
  }
}

// actions

- (void)digitPressed:(id)_sender {
  [self addDigit:[_sender tag]];
}

// operations

- (void)operate:(id)_sender {
  if (self->storedOperation > 0) {
    double newValue = 0.0;

    switch (self->storedOperation) {
      case 1: // add
        newValue = [self->display doubleValue] + self->storedValue;
        break;
      case 2: // subtract
        newValue = [self->display doubleValue] - self->storedValue;
        break;
      case 3: // multiplicate
        newValue = [self->display doubleValue] * self->storedValue;
        break;
      case 4: // divide
        if (self->storedValue == 0.0) {
          NSLog(@"division by zero !");
          newValue = 0.0;
        }
        else
          newValue = [self->display doubleValue] / self->storedValue;
        break;
    }
    [self->display setDoubleValue:newValue];
    self->storedOperation = 0;
  }

  self->storedValue      = [self->display doubleValue];
  self->storedOperation  = [_sender tag];
  self->resetOnNextDigit = YES;
}

// properties

- (void)setDisplay:(GTKEntry *)_widget {
  ASSIGN(self->display, _widget);
}
- (void)setWindow:(GTKWindow *)_window {
  ASSIGN(self->window, _window);
}

// notifications

- (void)applicationDidFinishLaunching:(NSNotification *)_notification {
  NSLog(@"app did finish launching ..");
  [window orderFront:nil];
}

@end
