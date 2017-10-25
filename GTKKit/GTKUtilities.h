/*
   GTKUtilities.h

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

// $Id: GTKUtilities.h,v 1.5 1998/08/05 13:42:02 helge Exp $

#ifndef __GTKKit_GTKUtilities_H__
#define __GTKKit_GTKUtilities_H__

#include <gtk/gtksignal.h>
#include <gtk/gtkobject.h>

#include <gtk/gtktypeutils.h>	// jet
#include <objc/objc.h>		// jet
#include <Foundation/Foundation.h> // jet

@class GTKObject;

#if GTK_MAJOR_VERSION == 1
#  define GTKKIT_GTK_1 1
#  if GTK_MINOR_VERSION == 1
#    define GTKKIT_GTK_11 1
#  else
#    define GTKKIT_GTK_11 0
#    define GTKKIT_GTK_10 1
#  endif
#else
#  define GTKKIT_GTK_1 0
#  define GTKKIT_GTK_0 1
#endif

extern const char *GTKDataSelf;

/*
  This takes an gtk argument structure and builds an object out of the
  contents. For basic types like int, uint, char or string the appropriate
  foundation objects are constructed, NSNumber and NSString.
  Arguments of type GtkObject become the Objective-C proxy or a NSValue
  pointer if non exists. Other pointer arguments like callbacks become
  NSValue-pointer objects.
 */
id gtkObjectifyArgument(GtkArg *arg);

/*
  This function forwards signals to the object. The ObjC-proxy for
  _obj receives the -handleEvent: message. The event is an object
  of class GTKSignalEvent and contains signal arguments, signal
  name and the receiver.
 */
void gtkSignalMarshaller(GtkObject *_obj, gpointer _context, guint ac, GtkArg *args);

/*
  The GTKGetObject function returns the Objective-C proxy object for a
  gtk-Object or nil, if it doesn't has one.
*/
id GTKGetObject(void *_gtkObj);

// This returns a description for the given justification
NSString *GTKJustificationDescription(GtkJustification _mode);

// This returns a description for the given selection mode
NSString *GTKSelectionModeDescription(GtkSelectionMode _mode);

#endif
