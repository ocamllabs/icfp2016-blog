---
title: Semantics of the Lambda intermediate language
author: gemmag (Gemma Gordon)
abstract: Friday 23rd 1520-1545 PM (OCaml 2016)
---

## Semantics of the OCaml backends
Semantics i would like to add to lambda, and how to get there

**Lambda:**

- intermediate representation of the compiler
- untyped lambda calculus
- first representation without types
- fork point between bytecode and native backends
- no more modules, objects, pattern matching

completely untyped so can't assume information about the modules - cannot recover type checking

**Why use lambda?**

- optimisations
- static analysis: lambda is simpler than ocaml, so simpler to analyse
- backend developers (js_of_ocaml, bucklescript, ocamlcc, ocamljava, cakeml)
- frontend developers
- semantics of obj (coq).

my main focus is optimisations and static analysis

several semantics for lambda
But not well defined and not practical for reasoning and it changes between versions.

**Existing semantics**

- ocamlrun (simple and clear, 2 versions)
- native backend (some subtle differences between archs)
- JavaScript (2 backends)
What is the intersection?

Defacto semantics - difficult to know what relies on what behaviour, not everything is well defined in the code itself. Need to decide what it should do versus what it is doing:

- don't constrain too many optimisations
- don't make too much code false
Not a simple language and difficult to reason about. It appears to manipulate ints and blocks - looking at memory

Need to add more types to lambda that would appear in the compiler:

- blocks
- arrays etc

Assignments are only defined on mutable blocks

Should the semantics depend on the shape of the code? Ideally not, but ocaml frontend relies on that, along with some libraries. Some existing unsafe code assumes some shape

**What you can check/observe**

- allocations - no. Won't work correctly in bytecode and native code
- GC roots - depends. Don't want some leaks
- evaluation order - depends. Sometimes good to define, others bad
- Stack
- Time
- Physical equality

mutable and heap allocated - you can write reasonable semantics about it. == equal equal. Immutable values should be undefined in ==. But will prevent some memoization if too strict and memoization is important for performance. Changes needed in the compiler

Don't want something as complicated as C

to get proper semantics we need:
- to outlaw some patterns
- make the compiler follow these rules
But it will have:
- a lot of undefined behaviours
- non determinism

## Conclusion

- users - magic is unsafe, don't use it
- OCaml compiler devs - work needed to make lambda sensible
- language implementors - target lambda or malfunction, not ocaml

## Q&A

Q: what is magic? unsafe coerce - bad! not for casual users

Q: we have to use obj.magic in some cases. A clear enough semantics so users know what the safe harbours are, eg. at the C level would be good. Understand that the compiler devs don't want to be tied to semantics, but documenting what the current semantics are would be helpful and required. semantics of C external is simpler than ocaml without magic. will still easily segfault using magic versions. Need to do know the deep compiler internals and think about that before writing code, so I wouldn't recommend using it. Agreed that documenting all of the semantics would be hard, but we could just document the easy/safe parts.

Q: Example of the shape of the code? Information might not be inlined and therefore not propagated. If you propogate it, then you are allowing for some more optimsations and later you can do some immutable optimsations. I'd like a concrete example though...
