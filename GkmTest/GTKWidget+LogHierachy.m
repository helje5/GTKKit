/*
   GTKWidget+LogHierachy.m

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

// $Id: GTKWidget+LogHierachy.m,v 1.2 1998/08/09 23:38:00 helge Exp $

#include <stdio.h>
#import <GTKKit/GTKKit.h>
#import "GTKWidget+LogHierachy.h"

@implementation GTKWidget(LogHierachy)

static inline void _printIndent(int _i) {
  _i = _i * 2;
  
  switch (_i) {
    case  0: break;
    case  2: fwrite("  ",             _i, 1, stdout); break;
    case  4: fwrite("    ",           _i, 1, stdout); break;
    case  6: fwrite("      ",         _i, 1, stdout); break;
    case  8: fwrite("        ",       _i, 1, stdout); break;
    case 10: fwrite("          ",     _i, 1, stdout); break;
    case 12: fwrite("            ",   _i, 1, stdout); break;
    case 14: fwrite("              ", _i, 1, stdout); break;
    default: {
      int cnt;
      for (cnt = 0; cnt < _i; cnt++)
        fwrite(" ", 1, 1, stdout);
      break;
    }
  }
}

- (void)printWidgetHierachyWithIndent:(int)_indent {
  _printIndent(_indent);
  
  printf("%s\n", [[self description] cString]);

  if ([self isKindOfClass:[GTKContainer class]]) {
    int cnt, subCount = [[(GTKContainer *)self subWidgets] count];

    for (cnt = 0; cnt < subCount; cnt++) {
      GTKWidget *subWidget;
      subWidget = [[(GTKContainer *)self subWidgets] objectAtIndex:cnt];

      [subWidget printWidgetHierachyWithIndent:_indent + 2];
    }
  }
}

@end
