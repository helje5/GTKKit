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
# $Id: GNUmakefile,v 1.6 1998/08/10 01:33:03 helge Exp $

GNUSTEP_INSTALLATION_DIR = $(GNUSTEP_USER_ROOT)

include $(GNUSTEP_SYSTEM_ROOT)/Makefiles/common.make

# -gd - generate trace output
# -gl - generate line info
ANTLR     = antlr
A_FLAGS   = -gl
DLG       = dlg
DLG_FLAGS = -C2 -i

LIBRARY_NAME = libGkmParse

PROTOCOLS = \

CATEGORIES = \
	GTKApplication+GkmLoading \

CLASSES = \
	GKModule       \
	GKMAttribute   \
	GKModuleParser \

PROTOCOLS_h		= $(addsuffix .h, $(PROTOCOLS))
CLASSES_m 		= $(addsuffix .m, $(CLASSES))
CLASSES_h 		= $(addsuffix .h, $(CLASSES))
CATEGORIES_m	= $(addsuffix .m, $(CATEGORIES))
CATEGORIES_h	= $(addsuffix .h, $(CATEGORIES))

$(LIBRARY_NAME)_HEADER_FILES = \
	GkmParse.h      \
	$(PROTOCOLS_h)  \
	$(CATEGORIES_h) \
	$(CLASSES_h)

$(LIBRARY_NAME)_OBJC_FILES = \
	$(CATEGORIES_m) \
	$(CLASSES_m)    \
	gkm_parser.m gkm_errors.m gkm_scanner.m

# jet
$(LIBRARY_NAME)_HEADER_FILES_DIR = .
$(LIBRARY_NAME)_HEADER_FILES_INSTALL_DIR = /GTKKit

include GNUmakefile.preamble
include $(GNUSTEP_SYSTEM_ROOT)/Makefiles/library.make
-include GNUmakefile.postamble

clean ::
	rm -f parser.dlg

scrub ::
	rm -f parser.dlg gkm_parser.m tokens.h
	rm -f mode.h gkm_scanner.m gkm_errors.m

parser :
	$(ANTLR) $(A_FLAGS) -fe gkm_errors.m gkm.g
	$(DLG) $(DLG_FLAGS) parser.dlg gkm_scanner.m
	mv gkm.c gkm_parser.m
	rm parser.dlg

GKMAttribute.m GKModuleParser.m : tokens.h
