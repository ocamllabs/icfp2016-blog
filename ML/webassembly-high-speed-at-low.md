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
