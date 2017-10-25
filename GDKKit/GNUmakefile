#
#   GNUmakefile
#
#   Copyright (C) 1998 Helge Hess.
#   All rights reserved.
#
#   Author: Helge Hess <helge@mdlink.de>
#
#   This file is part of GTKKit.
#
#   Permission to use, copy, modify, and distribute this software and its
#   documentation for any purpose and without fee is hereby granted, provided
#   that the above copyright notice appear in all copies and that both that
#   copyright notice and this permission notice appear in supporting
#   documentation.
#
#   We disclaim all warranties with regard to this software, including all
#   implied warranties of merchantability and fitness, in no event shall
#   we be liable for any special, indirect or consequential damages or any
#   damages whatsoever resulting from loss of use, data or profits, whether in
#   an action of contract, negligence or other tortious action, arising out of
#   or in connection with the use or performance of this software.
#
# $Id: GNUmakefile,v 1.9 1998/08/06 17:23:01 helge Exp $

GNUSTEP_INSTALLATION_DIR = $(GNUSTEP_USER_ROOT)

include $(GNUSTEP_SYSTEM_ROOT)/Makefiles/common.make

LIBRARY_NAME = libGDKKit

PROTOCOLS = \

CATEGORIES = \

CLASSES = \
	GDKColor      \
	GDKColorMap   \
	GDKDrawable   \
	GDKFont       \
	GDKGfxContext \
	GDKPixmap     \
	GDKScreen     \
	GDKVisual     \
	GDKWindow     \

PROTOCOLS_h		= $(addsuffix .h, $(PROTOCOLS))
CLASSES_m 		= $(addsuffix .m, $(CLASSES))
CLASSES_h 		= $(addsuffix .h, $(CLASSES))
CATEGORIES_m	= $(addsuffix .m, $(CATEGORIES))
CATEGORIES_h	= $(addsuffix .h, $(CATEGORIES))

$(LIBRARY_NAME)_HEADER_FILES = \
	GDKKit.h        \
	GDKTypes.h      \
	$(PROTOCOLS_h)  \
	$(CATEGORIES_h) \
	$(CLASSES_h)

$(LIBRARY_NAME)_OBJC_FILES = \
	$(CATEGORIES_m) \
	$(CLASSES_m)

# jet
$(LIBRARY_NAME)_HEADER_FILES_DIR = .
$(LIBRARY_NAME)_HEADER_FILES_INSTALL_DIR = /GTKKit

include GNUmakefile.preamble
include $(GNUSTEP_SYSTEM_ROOT)/Makefiles/library.make
-include GNUmakefile.postamble
