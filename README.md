lambda-learner
==============

A GUI tool to aid with learning the lambda calculus.

# Requirements

This program was written using reactive-banana and reactive-banana-wx version
0.8.0 using the Glasgow Haskell Compiler (GHC). GHC can be found at the [Haskell
Platform](http://www.haskell.org) or with your distribution's package manager.

reactive-banana-wx can be installed with: 

    cabal install reactive-banana-wx 

This library is depends wxwidgets development package. Currently, it seems that reactive-banana-wx only supports 
wxwidgets 2.9.

# Building

After installing the requisite dependencies, the program should compile using
can be compiled with: 

GHC with the -XRankNTypes flag.

