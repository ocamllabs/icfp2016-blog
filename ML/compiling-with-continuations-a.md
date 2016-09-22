---
title: Compiling with continuations and LLVM
author: your-uid-here (your-name-here)
abstract: Thursday 22nd 1145-1210 AM (ML 2016)
---

How to do efficient compilation from Manticore to LLVM?

Manticore's runtime model is quite different from C. Efficient first-class continuations are used for concurrency, and work stealing parallelism and exceptions. Return continutions are passed as arguments to functions. Since continuations are heap allocated, this makes `callcc ` cheap. Functions return by throwing to an explicit continuation.

The mismatch is moving from CPS to LLVM IR.

* efficient reliable tail calls
* garbage collection
* preemption and multithreading
* first class continuations

This is a problem shared by many higher order languages who want to use LLVM.

Efficient reliable tail calls are hard to do in LLVM. LLVM tail call support is shaky, and fixes are difficult. LLVM at least manages to clean up tail calls, but efficiency remains a problem. Every single function call is a tail call in Manticore so any overhead is going to impact.

*shows an x86 call stack with prologue and stack realignment*
