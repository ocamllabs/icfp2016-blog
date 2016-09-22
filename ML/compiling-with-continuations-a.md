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

how do others avoid this problem?
* MLTon avoids tail calls by using a trampoline
* GHC removes callee-save instructions

Manticore remove all overhead with a new calling convetion (JWA) plus the use of `naked` functions
* Naked functions blindly omit all frame setup _requiring_ the compiler to handle it yourself. Normally used by interrupt service routines and so on.
* Manticore marks every function as naked. The runtime system sets up the stack frame and compiler limits the number of spills (this is an idea borrowed from SMLNJ). All functions reuse the same frame and FFI calls are transparent since the stack stays aligned once its setup.

Garbage collection:
* Cannot use LLVM's GC support since this assumes a stack runtime model.
* Manticore's stack frame support does a heap exhaustion check.  The heap check is just one branch and didnt require any other modification to the GC aside from heap checks.

Continutions are a nice representation for suspended threads and manticore needs parallel execution. Multithreaded runtimes must asychronously suspend execution, but using a precise GC must keep track.  Preemption should only be done at specific safe points; hreads keep their heap limit pointer in shared memory, and threads are prempted by forcing a thread's next heap check to fail; and preempted threads reenter the runtime system via callcc  Non allocating loops are also given a heap test.

Preemptions need to also happen in the middle of a function though, and this doesnt work so well with callcc.  In CwC, we allocate a function closure to capture a continuation. However LLVM does not have first-class labels to create continuations easily!  This is not a feature that is easy to add to LLVM since it violates SSA, so must work around it.

The return address of a non-tail call is a label generated at runtime. Return conventions for C structs specify a mix of stack and registers.

Performance is good except for a minor regression involving autovectorisation.

Conclusion:
* Upstreaming JWA convention to LLVM.
* More implementation detail in a tech report and applying this to SML/NJ in the future.
