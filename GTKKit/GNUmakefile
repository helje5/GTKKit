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
# $Id: GNUmakefile,v 1.15 1998/08/16 20:21:01 helge Exp $

GNUSTEP_INSTALLATION_DIR = $(GNUSTEP_USER_ROOT)

include $(GNUSTEP_SYSTEM_ROOT)/Makefiles/common.make

LIBRARY_NAME = libGTKKit

PROTOCOLS = \
	GTKControl          \
	GTKFormatter        \
	GTKTableDataSource  \

CATEGORIES = \
	NSObject+TakeValues \
	NSArray+GList       \
	GTKObject+Bean      \

CLASSES = \
	GTKAccelLabel       \
	GTKAdjustment       \
	GTKAlignment        \
	GTKBox              \
	GTKButton           \
	GTKCheckButton      \
	GTKContainer        \
	GTKData             \
	GTKDialog           \
	GTKEditable         \
	GTKEntry            \
	GTKFileSelection    \
	GTKFixed            \
	GTKFrame            \
	GTKItem             \
	GTKLabel            \
	GTKLayoutInfo       \
	GTKList             \
	GTKListItem         \
	GTKMenu             \
	GTKMenuBar          \
	GTKMenuItem         \
	GTKMenuShell        \
	GTKMenuWindow       \
	GTKMiscWidget       \
	GTKNotebook         \
	GTKObject           \
	GTKPaned            \
	GTKPixmap           \
	GTKProgressBar      \
	GTKRadioButton      \
	GTKRange            \
	GTKScale            \
	GTKScrollbar        \
	GTKScrolledWindow   \
	GTKSeparator        \
	GTKSignalEvent      \
	GTKSingleContainer  \
	GTKSpinButton       \
	GTKTable            \
	GTKTableList        \
	GTKText             \
	GTKToggleButton     \
	GTKToolTips         \
	GTKToolbar          \
	GTKTree             \
	GTKTreeItem         \
	GTKWidget           \
	GTKWindow           \

PROTOCOLS_h		= $(addsuffix .h, $(PROTOCOLS))
CLASSES_m 		= $(addsuffix .m, $(CLASSES))
CLASSES_h 		= $(addsuffix .h, $(CLASSES))
CATEGORIES_m	= $(addsuffix .m, $(CATEGORIES))
CATEGORIES_h	= $(addsuffix .h, $(CATEGORIES))

$(LIBRARY_NAME)_HEADER_FILES = \
	GTKKit.h         \
	GTKApplication.h \
	GTKTimer.h       \
	GTKUtilities.h   \
	$(PROTOCOLS_h)   \
	$(CATEGORIES_h)  \
	$(CLASSES_h)

$(LIBRARY_NAME)_OBJC_FILES = \
	GTKApplication.m \
	GTKTimer.m       \
	GTKUtilities.m   \
	$(CATEGORIES_m)  \
	$(CLASSES_m)

# jet
$(LIBRARY_NAME)_HEADER_FILES_DIR = .
$(LIBRARY_NAME)_HEADER_FILES_INSTALL_DIR = /GTKKit

include GNUmakefile.preamble
include $(GNUSTEP_SYSTEM_ROOT)/Makefiles/library.make
-include GNUmakefile.postamble
