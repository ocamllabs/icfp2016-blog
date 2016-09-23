---
title: Generic programming in OCaml
author: ciaran16 (Ciaran Lawlor)
abstract: Friday 23rd 1545-1610 PM (OCaml 2016)
---

(Not entirely understood, some things are likely wrong)

### Generic programming is USEFUL

Types sometimes get in the way of modularity.

Example - the length of the list, the height of a tree, the height of an AST, code is all very similar.

Some functions to help with reusability, remove boilerplate code. `para`, `transform`, ...

OCaml already has some generic operations - `compare`, `hash` break *type abstraction*, Marshal from string breaks *type safety*.

Generic programming is another form of polymorphism (structural polymorphism).

Universe

### Generic programming is POSSIBLE in OCaml

Universe of finite types can be represented using GADTS.

Extensible universe and functions - extensible types require extensible functions.

**Ad-hoc polymorphism (overloading)** is now possible in OCaml, now that extensible variants are in OCaml, and by using PPX to provide nicer syntax, generate boilerplate code and simplify usage.

**Generic views** - I missed this, and the part that actually makes generic programming possible

### The library

Core - type reflection and introspection, extensible functions.

Views - generic views, generic combinators, user level.

PPX to be added - syntactic sugar for extensible functions.

Future work - support for modular implicits.

#### Type safe deserialisation

Main motivation for the library.

Support includes cycles, abstract types and objects, extensible and polymorphic variants.

(Not supported - closures, lazy types, records with polymorphic fields and GADTs with existential qualification)

**Abstract types** - only supported if the module that supports this type also exports a public representation that can be converted to and from.

**Comparison to other libraries** - 10 in Haskell, another OCaml library by Jeremy Yallop (but requires a preprocessor). Main limitation compared to other libraries is that there are no higher kinded types in OCaml.

**Work in progress** - needs more documentation, more views, more generic combinators, ppx.

### Summary

Generic programming increases expressibility and modularity.

Generic views reconcile low and high levels of detail.

The built in generic primitives may be replaced with *safer* alternatives.
