---
title: WebAssembly: high speed at low cost for everyone
author: avsm (Anil Madhavapeddy)
abstract: Thursday 22nd 1035-1100 AM (ML 2016)
---

Andreas Rossberg of Google tells us about the new [WebAssembly](https://github.com/WebAssembly) effort.

Want to make the web a place for languages other than JavaScript and enable
features that dont fit JavaScript. And it should be high performance (within
20% of native code). The problem with JS isnt its peak performance, but its
_predictable_ performance.

The Webassembly effort supersedes asm.js and (P)NaCl, and both of the teams
that were formerly on this are now on board with the new technology *(speaker
notes it was surprising this works out)*.

What it's not:
* not a programming language - it is targetted from a compiler and not written from hand
* not a separate VM in a browser - it is running on the same heap that the JavaScript VM is running on and requires no new software to be installed.
* not limited to the web - at least one person is working on a standalone VM for webassembly. Name is a misfit as its neither "web" nor "assembly" *general laughter*
* also: its not a walled garden of any time and is completely open spec and code

# Goals and Constraints

* Language independent, so no baked in concepts like an object model
* Hardware independent
* Fast to execute so we can factor out the commonality of all modern CPUs
* Safe to execute
* Determinstic
* Easy to reason about 
* Compact
* Easy to generate
* Fast to deoc-devalidate-compile
* Streamable
* Parallelisable

What is it:

* Byte code
* Stack machine
* Machine types and operations
* Structured control flow is very distinctive. No irreducible control flow. Q: tail calls? A: not in yet but in the 1.0+ agenda. Q: What about C->Webassembly? A: There is a PLDI paper which shows an algorithm designed for asm.js that compiles C to asm.js and that works for WebAssembly too.
* There is a type system and so the bytecode is fully typed.

*Shows a type rules slide*.  WebAssembly module has a bunch of functions and modules and a bunch of virtual registers. There is an s-expression format to write code manually, mainly written for the test suite but it has stuck and has now become the official concrete syntax *general laughter and applause from the audience*.

### Status

* Design and definition: 1.0 is almost available and strable
* Implementation: tech preview available in Chrome, Firefox and Edge
* Compilers: LLVM backend and emscriptem for asm.js
* Tools: basic text view and stepping in Chrome, but more tools are needed and ongoing.

### Roadmap

* Shipping and iterating after the minimal viable product (1.0) goes out.
* Aims to be on par with `asm.js`, focussing on C/C++ compilation first with more interesting features for high level languages later.

## Specification

We want a _formal_ specification with validation as a type system and small-step operational sematics. There is a [reference interpreter written in OCaml](https://github.com/WebAssembly/spec) as a proxy for the formal spec.  This is as close as possible to what you would write on paper for a formal specification. 

*Shows type and reduction rules which are translated to OCaml code*

**What went well with this**: All the usual functional programming advantages hold; fast development (3 days for initial interpreter). Fair concise and "speccy" code with lots of types and not too many bugs. ADTs and pattern matching are really essential! Functors avoid code duplication and many low-level types are available in OCaml (int32/64) so that blocks of memory can be accessed directly and cast appropriately. OCaml also good toolchain and available on many platforms that WebAssembly runs on.

However there was a clash of cultures since most people on WebAssembly are LLVM/C++ hackers and unfamilar with OCaml.

Pitfalls:
* Lack of operator overloading (int32/64) was annoying due to their pervasive use int he codebase.
* Nominal record label were a problem. Q: Why not use record disambiguation A: lots of warnings and its a half solution. Q: Why not use objects. A: Obviously not *audience laughter* but seriously due to lack of pattern matching on them.
* Semicolon confusion
* Syntax errors are abysmal
* Type inference and error messages
* Unspecified evaluation order since you have to pull code out into `let` bindings
* Syntax quirks (if vs let vs semicolon)
* Multiple equalities but no proper ones.
* Stateful source positions in ocamlyacc. Audience: use [menhir](http://gallium.inria.fr/~fpottier/menhir/)!

Wasm specific problems:
* No float32 and no unsigned arithmetics
* Unstable NaNs
* Big arrays limited to int size

Ecosystem:
* Binaries unavailable, particular Windows
* Build system churn and Windows solution. Generate a batch file to have a one button solution.

## Overall

Reference interpreter worked well, and is an official requirement for Wasm
feature adoption.  Its mostly maintained by 1-2 people so it needs more
contributors.  Its hard to read for those with no FP or formal semantics
backgrounds.

This version is 1.0 but what we really want is better support for high-level languges.  Multiple return values, GC, tagged value, closures, tail calls, exceptions, threads, SIMD and so on.

## Questions

*Q:* Have you looked at languages which do different stack things than C?
Haskell or Scheme for example (callcc).  *A:* Stack support isnt quite adequate
for C, which has to build a shadow stack since it is trusted in WA.  The
requirements for other languages are understood but not in 1.0. Go people also
want stack support but this will come later after 1.0.

*Q:* Have you thought about inter language interop?  *A:* Previous VMs have
this object model builtin which is required for interop but there is always an
impedance mismatch in these models. So WebAssembly doesnt really try -- it is
essentially a hardware abstraction and clients have to design their own interop
mechanism. *Q:* Does MVP have a C FFI? *A:* JavaScript is the FFI and WA can
call directly into it
