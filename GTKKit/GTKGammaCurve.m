/*
   GTKGamma.m

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

// $Id: GTKGammaCurve.m,v 1.3 1998/08/16 13:49:00 helge Exp $

#import "common.h"
#import "GTKGammaCurve.h"

@implementation GTKGammaCurve

+ gammaCurve {
  return [[[self alloc] init] autorelease];
}

- init {
  return [self initWithGtkObject:(GtkObject *)gtk_gamma_curve_new()];
}

// private

- (GtkGammaCurve *)gtkGammaCurve {
  return (GtkGammaCurve *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_gamma_curve_get_type();
}

@end
