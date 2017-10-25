/*
   GTKMiscWidget.m

   Copyright (C) 1998 Helge Hess.
   All rights reserved.

   Author: Helge Hess <helge@mdlink.de>

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

// $Id: GTKMiscWidget.m,v 1.1 1998/07/09 06:07:32 helge Exp $

#import "GTKKit.h"
#import "GTKMiscWidget.h"

@implementation GTKMiscWidget

// accessors

- (void)setAlignment:(gfloat)_xAlign:(gfloat)_yAlign {
  gtk_misc_set_alignment((GtkMisc *)gtkObject, _xAlign, _yAlign);
}
- (void)getAlignment:(gfloat *)_xAlign:(gfloat *)_yAlign {
  *_xAlign = ((GtkMisc *)gtkObject)->xalign;
  *_yAlign = ((GtkMisc *)gtkObject)->yalign;
}

- (void)setPadding:(gint)_xPad:(gint)_yPad {
  gtk_misc_set_padding((GtkMisc *)gtkObject, _xPad, _yPad);
}
- (void)getPadding:(gint *)_xPad:(gint *)_yPad {
  *_xPad = ((GtkMisc *)gtkObject)->xpad;
  *_yPad = ((GtkMisc *)gtkObject)->ypad;
}

// private

- (GtkMisc *)gtkMisc {
  return (GtkMisc *)gtkObject;
}
+ (guint)typeIdentifier {
  return gtk_misc_get_type();
}

@end
