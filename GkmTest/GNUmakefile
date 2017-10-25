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
# $Id: GNUmakefile,v 1.4 1998/08/10 01:54:44 helge Exp $

include $(GNUSTEP_SYSTEM_ROOT)/Makefiles/common.make

TOOL_NAME = test

$(TOOL_NAME)_OBJC_FILES = \
	test.m \
	MainController.m \
	SpinController.m \
	\
	GTKWidget+LogHierachy.m \
	GTKWidget+Toggle.m      \

include GNUmakefile.preamble
include $(GNUSTEP_SYSTEM_ROOT)/Makefiles/tool.make
-include GNUmakefile.postamble
