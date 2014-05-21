lambda-learner
==============

A GUI tool to aid with learning the lambda calculus.

# Requirements

* reactive-banana-wx >= 0.8.0
* ghc >= 7.5
* happy >= 1.18.19
* alex >= 3.0.1

This program was written using reactive-banana and reactive-banana-wx version
0.8.0 using the Glasgow Haskell Compiler (GHC). GHC can be found at the [Haskell
Platform](http://www.haskell.org) or with your distribution's package manager.
The Happy package is used for parsing inputted text.

Haskell libraries  can be installed with: 

    cabal install reactive-banana-wx happy alex

This library is depends wxwidgets development package. Currently, reactive-banana-wx only seems to support 
wxwidgets 2.9. 

# Building

Build lambda-learner using:

    make 

Alternatively the program can be compiled manually with: 

    ghc -XRankNTypes lambda-learner.hs

