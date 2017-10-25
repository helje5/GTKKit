# GTKKit

Section: H's Computer History Museum

Looks like I wrote a GTK/GNOME Objective-C wrapper in 1998.
If I remember right, I thought that GNUstep UI was not going to happen and that
it would be a better approach to come up with AppKit like interface for
KDE and GNOME.

> Please note that GTKKit isn't supposed to be a nice gtk+ wrapper. The goal is
> to provide OpenStep programmers a convenient start into X11. So many things 
> which you used to have in gtk+, like signals are replaced by similiar but
> different stuff, like NSNotificationCenter's

## Links

- [Re: [gtk-list] Re: Objective-C binding](https://mail.gnome.org/archives/gtk-list/1998-March/msg00150.html)
- [GNUstep is a whole new can of worms](https://mail.gnome.org/archives/gtk-list/1998-March/msg00122.html)

## Original README

    # $Id: README,v 1.18 1998/08/17 00:04:52 helge Exp $

    GTKKit-170898-release

    [News]

    08/17/1998: Did some tricks in GTKNotebook to make it accessible in gkm files.
    08/16/1998: Started Calculator, a very simple demo program to get people started.
                Fixed up include files in GTKKit.
                Made description files support property lists as attribute values.
                Cleaned up handling of attributes in GKMParseHandler.
                Support for initWithPropertyList: method in GKModule (used in TableList)
                GTKObject's became 'Beans' (they support initWithPropertyList:)
    08/15/1998: Made menus more GTKContainer like (fixed method names)
                Changed OBJECT tag to REFERENCE tag.
    08/10/1998: The description-language is getting running. In GkmParse and GkmTest
                are examples. You can use an XML like description file to build up
                gtk+ interfaces. It is based on pccts (see www.antlr.org).
                Take a look into test.gkm for more information.
                I'm using gtk+-1.1.1 now. There seem to be some problems with themes,
                although I didn't take a deeper look into this.

    08/09/1998: Removed GTKHoriz/Vert*.[hm] files. The subclass for horizontal and
                vertical kinds of widgets are now placed in the file of the superclass.
                (Eg GTKHorizSeparator is now in GTKSeparator)

    08/05/1998: Compiles with gtk+-1.1.1
                Wrappers for the gdk-library started (not yet integrated with GTKKit)
                Warning: I upgraded to gtk+-1.1.1, so maybe it won't compile on older
                         versions. gtk+-1.1 should be stable when GTKKit is ..

    [GTKKit]

    GTKKit is an Objective-C wrapper around the C library functions of gtk+, the GIMP 
    Toolkit library. It is designed towards the FoundationKit although it isn't 
    compatible with the ApplicationKit.

    There exist two other Objective-C gtk+ bindings, one is named obgtk and is some 
    kind of 'standard' binding. The obgtk library is used in the GNOME project. In the 
    gtk-mailing-list came up an announcement of another ObjC binding, but it seems to 
    be not yet available.

    The major difference between obgtk and GTKKit are:

      - obgtk uses Object as the root-class, GTKKit uses NSObject
      - obgtk is modelled after the gtk+ widget idea (with the signal concept),
        while GTKKit's design is oriented more towards the OpenStep 
        Application Kit
      - obgtk seems to be used in the GNOME project, GTKKit isn't used anywhere, 
        yet ;-)
      - obgtk comes with it's own makefiles while GTKKit uses the gstep-make
        package

    It's up to everybody to decide himself which library to use. Since I like
    the FoundationKit I couldn't use obgtk in a nice way. I'm also used to work
    with NeXTstep, so I like to have a more OpenStep-stylish way of programming.

    [GDKKit]

    It turns out that support for the gdklib is implemented as well. It's name is GDKKit.
    This contains an abstraction of the X11 model. Don't confuse this with gtk+, which is
    a widget toolkit based on X11. With gdk you can do low-level stuff like drawing and
    font-handling. gdk and gtk is much like DPS and AppKit.

    [Requirements]

    You need:

      gstep-base-0.5.0 or libFoundation-0.8
      gstep-make-0.5.0
      gtk+-1.0.4 or gtk+-1.0.5 (maybe you should try gtk+-1.1 [this is not declared stable])

    If you compile GTKKit with gstep-base instead of libFoundation, you may need the 
    FoundationExtensions library, but I'm not sure.

    [Installation]

    Just unpack the archive and type

      make shared=no debug=yes gc=no

    And it should work :-)
    This creates a library called GTKKit and a small test program named GTKTest. The 
    test program doesn't test everything that is available. Once there was another test 
    program but this was deleted to build one that looks like the standard-C-gtk test 
    program.

    [Copying & Distribution]

    As noted in each GTKKit file:

      --snip--
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
      --snap--

    In general I would appreciate it if

      GTKKit
      my Name     (Helge Hess <helge@mdlink.de>)
      my Company  (MDlink online service center GmbH Magdeburg, Germany)

    are mentioned in the README/InfoPanel if you develop a nice application
    using GTKKit or redistribute the kit.

    [Maintenance]

    Currently the GTKKit isn't activly developed, since I'm somewhat busy. If
    anybody is willing to manage the kit, I would be quite happy. I'm interested
    in seeing this binding becoming a usable way to write GUI applications for
    X11.
    While the use of GTKKit stays bounded I'm willing to incorporate patches and
    to do little bugfixes.


    Greetings
      Helge

    --
    Helge Hess <helge@mdlink.de>
    MDlink online service center GmbH (http://www.mdlink.de/)
    Magdeburg, Germany
