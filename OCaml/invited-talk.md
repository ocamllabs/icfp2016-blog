---
title: Invited Talk (State of OCaml)
author: avsm (Anil Madhavapeddy)
abstract: Friday 23rd 0910-0935 AM (OCaml 2016)
---

Damien Doligez presents the year in OCaml. Major release 4.03 in April 2016 and flambda, ephemereons

## Flambda

Pierre Chambart, Mark Shinwell and Leo White built a new intermediate
language in the compiler that performs a number of optimization passes on the
IL, such as inlining across modules and abstraction layers, specialization,
unboxing and pattern matching branch merging.

It is a huge patch to the compiler with 43 new modules and 16k lines of code.
It is a configure flag and adds 21 (!) command line flags.  It is currently not
possible to mix and match flambda files, but thanks to OPAM it is not a problem
to switch to a new version

```
type color = Red | Green | Yellow
type fruits =
 | Apple of int * color
 | Oranges of int
 | Bananas of int * float

let number_of_fruits1 = function
 | Apples (n,_) -> n
 | Oranges n -> n
 | Bananas (n,_) -> n
```

a more optimal but unsafe version

```
Obj.field (Obj.repr f) 0
```

If you look at the lambda code with `ocamlopt -c -dcmm foo.ml`

8+12 instructions for the second one and 2 instructions for the safe one!  The
unsafe Obj version has dead code since it has to do a runtime test for a float
array, whereas the flambda one is completely optimal since it examines the
types and does a load and return.

## Ephemereons

Presents 2 years ago here and originally 5 years ago, but finally upstreamed by Francois Bobot.  If you are a user of weak pointers and frustrated when memoising functions, then ephemerons are exactly what you need.  It is _n_ keys (weak pointers) and one data pointer (a conditional strong pointer).  The data pointer is erased as soon as one of the keys is erased.

## Other 4.03 things

* Improved GADT checking
* constructors with inline arguments
* immediate attribute on types
* marshaling of large values
* GC pause time improvements
* colors in compiler warnings and errors!
* many small syntax improvements
* UChar module and result type in stdlib

## Release Process

4.03 was quite painful to release and 4 months behind schedule.  Therefore we are switching to a deadline based release process on a 6 month release schedule.  Instead of deciding on the feature set and waiting for them all to be ready, we take the features that are ready at a given date. 

4.04 is the first release to use this process and was frozen on the 1st Aug 2016. 4.05 will be frozen on the 1st Feb 2017.

## Whats next in 4.04?

4.04 is coming soon.  It features:

* the SpaceTime profiler and tells you a lot about their memory behaviour. 
* local exceptions
* ocamllex supports `-safe-string`
* installs the native version of the tools by default (ocamlc.opt)
* more extensive work on flambda and other optimisations

Further down the line (not scheduled yet)
* modular implicits
* algebraic effects
* multicore OCaml

## Closing

Try to port your code to "safe string" mode, as it will soon become the default, possibly even for 4.05.  It will possibly even become mandatory because unsafe string mode may become unlinkable with safe code if some patch goes in.

OPAM package your code and support the OCaml platform.
