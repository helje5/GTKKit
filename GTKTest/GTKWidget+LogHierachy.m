// $Id: GTKWidget+LogHierachy.m,v 1.1 1998/07/10 12:50:02 helge Exp $

#include <stdio.h>
#import <GTKKit/GTKKit.h>

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
