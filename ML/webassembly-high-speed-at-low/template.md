---
title: ML 2016: WebAssembly: high speed at low cost for everyone
author: jdjakub (Joel Jakubovic)
abstract: WebAssembly: high speed at low cost for everyone
---

WebAssembly - new binary format to bring *native perf* to web

Participation of major browser vendors.

Zillion compilers that target JS - but pretty ill matched as a compilation target. Can also include JS-bad features eg threads.

Even though JS can have within 20% of native perf, we want *reliable* and *predictable* perf.

Will supersede asm.js and Google's NaCl.

Not a PL, technically - not for humans to write.
Also not a new VM - same web engine.
Not limited to the web (actually, neither Web nor Assembly...)
Not encumbered by copyrights, patents, etc.

## Goals
Semantics
--
Language-independent
HW independent - factor out commonalities of modern CPUs
Fast to execute
Safe to execute
Deterministic and easy to reason about

Rep
--
Compact
Easy to generate
Fast to decode + validate + compile
Streamable
Parallelizable


Bytecode, stack machine. Operates on machine word types. *Structured* control flow! No spaghetti jumps. By def, no irreducible control flow.

Q: What about C?
A: Paper about translating those control structs into this style.

Also, fully typed!

As usual with S-expressions, was an initial concrete syntax but got adopted as official! (hahaha)

1.0 almost stable, tech previews available. Want to be on par with asm.js, focussing initially on C/C++.

Validation as type sys, plus small-step op semantics.

Currently, specified by implementation (:D) in OCaml!

All the usual advantages of FP apply. Fast, took 3 days to get up and running. How can anybody still survive without ADTs and pattern matching? Functors avoid duplication, plus OCaml let us easily use many low-level types eg int23/64, bigarrays.

Culture clash: most people are compiler hackers with C/C++ backgrounds:

"I cannot read this, makes me sad"
"Can we redo this in a real language, C++ or Python(!)"
"Could you please use longerVariableNames?"

Barriers to entry:
More avoidable things; unfortunate OCaml design decisions.
Lack of op overloading.
Nominal record labels.
Semicolon / double semicolon weirdness.
"Syntax error." nuff said.
Functors - barrier to entry for many.

Pitfalls
Unspecified evaluation order.
Syntax quirks (rock-paper-scissors precedence of `if` vs `let` vs `;`)
Which equality to use?
OCamlyacc - get source positions statefully. ("Use Menhir!")
Unstable NaNs
No float32, lack of unsigned arithmetic

Ecosystem
Windows (lack of) support
Build system churn - huge batch file D:

The future
Better support for HLL - already started work, looking at next year. GC, tail calls, closures, exceptions, etc
Write compilers for your fave HLL, help us overcome the JS monopoly!

Q: Does your MVP have a way of reaching DOM from C?
A: You can import JS function calls.
