/*
   GDKVisual.m

   Copyright (C) 1998 Helge Hess.
   All rights reserved.

   Author: Helge Hess <helge@mdlink.de>

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

// $Id: GDKVisual.m,v 1.8 1998/08/06 17:23:00 helge Exp $

#import "common.h"
#import "GDKVisual.h"

@interface GDKVisual(privateMethods)

- (id)initWithGdkVisual:(GdkVisual *)_visual;

@end

@implementation GDKVisual

static NSMapTable *gdkToKit = NULL;

static inline GDKVisual *_objectForGdkVisual(GdkVisual *_gdkVisual) {
  GDKVisual *visual = (GDKVisual *)NSMapGet(gdkToKit, (void *)_gdkVisual);

  if (visual == nil) {
    visual = [[GDKVisual alloc] initWithGdkVisual:_gdkVisual];
    NSMapInsert(gdkToKit, _gdkVisual, (void *)visual);
  }
  return visual;
}

+ (void)initialize {
  static BOOL isInitialized = NO;
  if (!isInitialized) {
    isInitialized = YES;

    gdkToKit = NSCreateMapTable(NSNonOwnedPointerMapKeyCallBacks,
                                NSObjectMapValueCallBacks,
                                16);
  }
}

// constructors

+ (GDKVisual *)systemVisual {
  return _objectForGdkVisual(gdk_visual_get_system());
}
+ (GDKVisual *)bestVisual {
  GdkVisual *gv = gdk_visual_get_best();
  return gv ? _objectForGdkVisual(gv) : nil;
}
+ (GDKVisual *)bestVisualWithDepth:(gint)_depth {
  GdkVisual *gv = gdk_visual_get_best_with_depth(_depth);
  return gv ? _objectForGdkVisual(gv) : nil;
}
+ (GDKVisual *)bestVisualWithType:(GdkVisualType)_type {
  GdkVisual *gv = gdk_visual_get_best_with_type(_type);
  return gv ? _objectForGdkVisual(gv) : nil;
}
+ (GDKVisual *)bestVisualWithDepth:(gint)_depth andType:(GdkVisualType)_type {
  GdkVisual *gv = gdk_visual_get_best_with_both(_depth, _type);
  return gv ? _objectForGdkVisual(gv) : nil;
}

- (id)initWithGdkVisual:(GdkVisual *)_visual {
  if ((self = [super init])) {
    NSAssert(_visual, @"invalid visual passed to GDKVisual-init");
    
    gdkVisual = _visual;
    gdk_visual_ref(gdkVisual);
  }
  return self;
}

- (void)dealloc {
  gdk_visual_unref(gdkVisual); gdkVisual = NULL;
  [super dealloc];
}

// class methods

+ (gint)bestVisualDepth {
  return gdk_visual_get_best_depth();
}
+ (GdkVisualType)bestVisualType {
  return gdk_visual_get_best_type();
}

+ (NSArray *)allVisuals {
  GList *visuals = gdk_list_visuals();

  if (visuals) {
    gint count = g_list_length(visuals);
    id   array[count];
    gint pos = 0;

    for (pos = 0; pos < count; pos++, visuals = visuals->next) {
      array[pos] = _objectForGdkVisual((GdkVisual *)visuals->data);
    }

    return [NSArray arrayWithObjects:array count:count];
  }
  else
    return nil;
}

// accessors

- (GdkVisualType)visualType {
  return gdkVisual->type;
}
- (gint)depth {
  return gdkVisual->depth;
}
- (GdkByteOrder)byteOrder {
  return gdkVisual->byte_order;
}

// private

+ (GDKVisual *)visualForGdkVisual:(GdkVisual *)_gdkVisual {
  return _objectForGdkVisual(_gdkVisual);
}

- (gint)colorMapSize {
  return gdkVisual->colormap_size;
}
- (gint)bitsPerRGB {
  return gdkVisual->bits_per_rgb;
}
- (GdkVisual *)gdkVisual {
  return gdkVisual;
}

// description

- (NSString *)description {
  return [NSString stringWithFormat:
                     @"<Visual: gdk=0x%08X depth=%i bitsPerRGB=%i colorMapSize=%i>",
                     [self gdkVisual], [self depth],
                     [self bitsPerRGB], [self colorMapSize]
                   ];
}

@end
