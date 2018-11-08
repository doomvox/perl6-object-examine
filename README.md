NAME
====

Object::Examine - additional object introspection methods

SYNOPSIS
========

    use Object::Examine;
    $some_random_object does Introspector;
    say $some_random_object.menu;

DESCRIPTION
===========

This module makes an `Introspector` role available which adds some additional object introspection methods, notably a wrapper around the "^methods" method named "menu".

Methods
-------

  * menu -- a long menu of available methods, one per line

The `menu` method uses the .^methods(:local) list as a source, but filters and sorts it, and adds a second column showing the Class it comes from.

Internal Routines
-----------------

  * methods_for 

  * clean_methods

MOTIVATION
==========

There's a useful meta-method named "^methods" which gives you a list of available methods on an object or class, but unfortunately it uses a format which is perhaps LTA for human consumption:

    my $set = Set.new(<alphan betazoid gammera>);
    say $set.^methods;

    # (iterator clone STORE keyof grab SET-SELF Real elems roll Numeric new-from-pairs total pickpairs RAW-HASH of Int Num default grabpairs fmt Capture pick WHICH Method+{is-nodal}.new Method+{is-nodal}.new Method+{is-nodal}.new Method+{is-nodal}.new Method+{is-nodal}.new Method+{is-nodal}.new Method+{is-nodal}.new new Method+{is-nodal}.new Method+{is-nodal}.new minpairs maxpairs Bool Method+{is-nodal}.new Method+{is-nodal}.new ACCEPTS Str gist perl Method+{is-nodal}.new Method+{is-nodal}.new Method+{is-nodal}.new Method+{is-nodal}.new Method+{is-nodal}.new Method+{is-nodal}.new Method+{is-nodal}.new BUILDALL)

This list is not sorted, it contains redundant entries, and it includes the rather mysterious "Method+{is-nodal}.new" which the average user probably does not want to hear about. By default, it's not very complete, and you might want to use ".^methods(:all)" to look all the way up the inheritance chain, presuming you knew about that option.

The "menu" method tries to fix these issues, though at the expense of being rather verbose: 

    $set does Introspector;
    $set.menu

    # ACCEPTS                   Set                      
    # BIND-POS                  Any                      
    # BUILDALL                  Set                      
    # BUILD_LEAST_DERIVED       Mu                       
    # Bool                      Set                      
    # CREATE                    Mu                       
    # Capture                   Set                      
    # DUMP                      Mu                       
    #  ...
    # item                      Mu                       
    # iterator                  Set                      
    # keyof                     Set                      
    # lazy-if                   Any                      
    # match                     Any                      
    # maxpairs                  Set                      
    # minpairs                  Set                      
    # new                       Set                      
    # new-from-pairs            Set                      
    # nl-out                    Any                      
    #  ...

Note that the second column tells you the Class that defines the method, which may help find appropriate documentation.

AUTHOR
======

Joseph Brenner, doomvox@gmail.com

COPYRIGHT AND LICENSE
=====================

Copyright (C) 2018 by Joseph Brenner

Released under "The Artistic License 2.0".
