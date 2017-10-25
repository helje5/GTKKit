/*
   GTKHandle.m

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

// $Id: GTKHandle.m,v 1.3 1998/07/13 10:55:32 helge Exp $

#import "GTKKit.h"
#import "GTKHandle.h"


// default handle pixmap
static char *handle_h[] = {
"30 8 7 1",
". c #000000",
"# c #303060",
"a c #6064c8",
"b c #707070",
"c c #c0c0c0",
"d c #e8e8e8",
"e c #f8fcf8",
"dddddddddddddddddddddddddddddd",
"dccccccccccccccccccccccccccccb",
"dccc#ccccccecceccecceccecceccb",
"dccc##cccccc#cc#cc#cc#cc#ccccb",
"dccc#a#ccccceccecceccecceccccb",
"dccc#aecccccc.cc.cc.cc.cc.cccb",
"dccc#ecccccccccccccccccccccccb",
"dbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"
};

static char *handle_v[] = {
"9 30 7 1",
". c #303060",
"# c #6064c8",
"a c #707070",
"b c #808080",
"c c #c0c0c0",
"d c #e8e8e8",
"e c #f8fcf8",
"ddddddddd",
"dccccccca",
"dccccccca",
"d.....bca",
"dc.##ecca",
"dcc.eccca",
"dccccccca",
"dccccccca",
"dccceccca",
"deccc.cca",
"dc.ccccca",
"dccceccca",
"deccc.cca",
"dc.ccccca",
"dccceccca",
"deccc.cca",
"dc.ccccca",
"dccceccca",
"deccc.cca",
"dc.ccccca",
"dccceccca",
"deccc.cca",
"dc.ccccca",
"dccceccca",
"deccc.cca",
"dc.ccccca",
"dccceccca",
"dccccccca",
"dccccccca",
"daaaaaaaa"
};


@implementation GTKHandle

+ handle {
   return [[[self alloc] init] autorelease];
}

+ handleHorizontal {
   return [[[self alloc] initHorizontal] autorelease];
}

+ handleVertical {
   return [[[self alloc] initVertical] autorelease];
}

- initHorizontal {
  self = [super init];
  if (self) {
    [self addSubWidget:[GTKPixmap pixmapFromData:handle_h]]; 
  }
  return self;
}

- initVertical {
  self = [super init];
  if (self) {
    [self addSubWidget:[GTKPixmap pixmapFromData:handle_v]]; 
  }
  return self;
}

- (void)boundToParentSize {
  bound = YES;
}

- (void)setMotionToWidget:(GTKContainer*)_widget {
  if (!GTK_IS_CONTAINER([_widget gtkObject]) ) {
    NSLog(@"no valid container to connect");
    return;
  }
  
  widget = _widget;
  [self observeSignalsWithNames:
          @"motion_notify_event",
          @"button_press_event",
          @"button_release_event",
          nil];

  gtk_widget_set_events ((GtkWidget*)gtkObject, 
                         GDK_POINTER_MOTION_MASK
                         | GDK_BUTTON_PRESS_MASK
                         | GDK_BUTTON_RELEASE_MASK
                         | GDK_POINTER_MOTION_HINT_MASK);
}

- (void)motionNotifyEvent:(NSDictionary *)args {
  GdkEventMotion  *event;
  GdkModifierType state;

  event = (GdkEventMotion*)[[[args objectEnumerator] nextObject] pointerValue];

  if (event->is_hint) {
    gdk_window_get_pointer (event->window, &wxPos, &wyPos, &state);
  }
  else {
    wxPos = event->x;  wyPos = event->y;
    state = event->state;
  } 

  if (!mxPos && !myPos) // get shure the mouse button is pressed
    return;
  
  if (state & GDK_BUTTON1_MASK) {
    if (bound) {
      GTKWidget *p = [widget superWidget];
      if (wxPos-mxPos > [p width] -[widget width] ) return;
      if (wyPos-myPos > [p height]-[widget height]) return;
    } 
    [widget setPosition:wxPos-mxPos :wyPos-myPos];
  }
}

- (void)buttonPressEvent:(NSDictionary *)args {
  // NSLog(@"button press");
  mxPos = wxPos - [widget xPos]; 
  myPos = wyPos - [widget yPos];
}

- (void)buttonReleaseEvent:(NSDictionary *)args {
  // NSLog(@"button release");
  mxPos = 0; 
  myPos = 0;
}

- (void)handleEvent:(GTKSignalEvent *)_event {
  NSString *_signalName = [_event signalName];
  
  if   ([_signalName isEqualToString:@"motion_notify_event"])   
    [self motionNotifyEvent:_args ];
  else if ([_signalName isEqualToString:@"button_press_event"])
    [self buttonPressEvent:_args];
  else if ([_signalName isEqualToString:@"button_release_event"])
    [self buttonReleaseEvent:_args];
  else
    [super handleEvent:_event];
}

@end










