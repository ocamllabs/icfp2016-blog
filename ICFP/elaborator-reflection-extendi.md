---
title: Elaborator reflection: extending Idris in Idris
author: OlivierNicole (Olivier Nicole)
abstract: Tuesday 20th 1530-1555 PM (ICFP 2016)
---

Exhortation: "You should control your programming language!"

# Extend Your Compiler

We can extend our compiler with new features without having to rebuild it from
scratch.

## How does it work?

Inside Idris, we have a Core Language called TT. The translation from high-level
Idris to TT is called *elaboration*.

## Elaboration Challenges

* Disambiguation
* All these are interpendent

This internalizes a Haskell monad with states and errors.

## Tactics

* intro
* fill
* focus
* claim
* resolveTC (typeclass)
* search

# Metaprogramming with Dependent Types

Several approaches:
* Internal metaprogramming
* Tatic languages
* Reified Expressions
All have downsides.

New approach in Idris: directly expose the elaborator of metaprograms.
This involves a type `Elab a`.

Then the speaker gave a bunch of complicated examples that use `Elab`.

# Re-use Capabilities of Your Compiler

Capabilities of the compiler can be re-used, e.g. to elaborate DSLs.
