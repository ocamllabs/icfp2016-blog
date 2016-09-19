---
title: A new verified compiler backend for CakeML
author: your-uid-here (your-name-here)
abstract: Monday 19th 1340-1405 PM (ICFP 2016)
---

CakeML is a descendant of ML. It has formalized semantics in HOL4.

* End-to-end verified compilation from CakeML to x86-64.

## v1.0 drawbacks

* Too low-level for FP optimizations, awkward for target-specific optimizations.
* Only one target available.

## v2.0

* New backend designed for verified optimizations
* Configurable + multiple targets
* Basic support for FFI
* 12 ILs for optimization.

## ClosLang

ClosLang is a new IL of v2.0. It allows for functional-style optimizations, like
multi-argument functions and closure conversion.

## CakeML backend

* Values in terms of 32-/64-bit words
* Configurable data representation

The new backend also introduces an abstract GC specification.

Next step:
* Concretize stack representation
* Flatten code, compile to assembly
* Encode assembly to target ISA.

## Compiler semantics preservation

### Observational semantics preservation

If the semantics of a program is not an error, then it is preserved by
compilation (up to the point where it stops with an out-of-memory error).

Proof sizes: 100 K lines of HOL4, 6 developers, 2 years. We have a fine-grained
control over the role of each IL.

To achieve this, data abstraction has complex invariants.

## Ongoing & future work

* Charguéraud's characteristic formulæ (ICFP '10, '11)
* New compiler optimizations
* v2.0 compiler bootstrap
* Generational garbage collection

