---
title: Backpack to work: towards Backpack in practice
author: avsm (Anil Madhavapeddy)
abstract: Saturday 24th 1035-1100 AM (HIW 2016)
---

Backpack is a module system for Haskell should be merged for GHC 8.2 (oked by spj)

Motivation: there are many different string variations. Bytestring is used by attoparsec, and text has a different attoparsec-text fork.  All the imports have to change if you want to change the representation and the ecosystem cannot keep up.

How can Backpack solve the string problem in haskell? Instead of having attoparsec depend on an implementation of String, then depend on an abstract signature. bytestring, text and foundation can all be implementations that provide a module that matches the "Str" interface. You can typecheck attoparsec by itself without all the implementations.

Idea:
* Packages not modules. A way to provide "strong modularity" without modifying the source language.
* This is not quite like ML modules since it is not as fine grained. 
* Using the idea of mixins not functors.

Explictly passing around functors gets old. mixins are wildcard records + thinning/renaming.
Explictly managing sharing constraints gets old. This is why ML functors are hard for people to understand, and it would be better if packages just fused equalities automatically.

Principle: Package manager is source code independent. That is, the package manager must only use binary artefacts. 
Corollaary: Signatures should be tracked per package, not per instance.

Mix-in linking can be separated into two algorithms: one language agnostic. From the perspective of a user, there is a nice surface language so they do not need to write these functor abstractions explicitly.

Couple of good examples worth looking at:
* System.Posix has been reimplemented
* Tagstream-conduit 

Package manager vs compiler:
* version based dependency resolution
* anti modular language features (type classes, open type families)

