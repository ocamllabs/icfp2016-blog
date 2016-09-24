---
title: Statistically profiling memory in OCaml
author: OlivierNicole (Olivier Nicole), gemmag (Gemma Gordon)
abstract: Friday 23rd 1040-1105 AM (OCaml 2016)
---

"Why does my program eat so much memory?"

# Solution 1: profiling allocations

One may use a generic profiler for the runtime, with a focus on allocations. But
released blocks will not be counted, therefore the heap will not be faithfully
measured.

# Solution 2: attach meta-data to blocks

At each allocation, attach meta-data about the allocation point and when needed,
analyze the metadata on the heap. This approach is used by `ocp-memprof`
(identifier of allocation site) and `Spacetime` (pointer to call graph). But
this incurs an overhead.

# A statistical memory profiler

**Track only a small, representative fraction of allocations.**

The overhead is much lower.

Characteristics:
* Tunable sampling rate.
* Relevant information even for low sampling rates.
* Ability to attach much larger metadata, hence to get full stack traces, the
  values of some variables, etc.

# Architecture

*Only the runtime system* is added to the runtime.

A user-chosen OCaml closure is called when sampling a block.

## Sampling engine

Allocation is seen as a flow of blocks. Samples are thrown at random (Poisson
process) at a tunable rate.

## Implementation in the runtime

* Major heap: direct simulation of Poisson process
* Minor heap: other mechanism with exponential rate.

## OCaml side

The set of tracked blocks is tracked by OCaml code. It uses ephemerons, that
were introduced in OCaml 4.03.

# Evaluation

* Every allocation can be sampled
* Good performance: with lambda = 10^(-5), the overhead is < 1 %.
  With lambda = 10^(-4), the overhead is < 10 %.
* The profile is *very* representative.

-----------

## Gemma Gordon's notes

Memory profilers:
- memory leaks
- inefficient data structures

Usually seen when using program on a large scale with large sections of data

### Solution 1:
Profiling allocations
- use a generic profiler for runtime which focuses on allocations
BUT does not faithfully represent the heap

### Solution 2:
attach meta-data to blocks
at each allocation attach meta-data, when needed analyze the meta-data in the heap

- ocp-memprof: identifier of allocation site
- spacetime: pointer to call graph

work BUT runtime/memory overhead which means you need a limited amount of info to mitigate. Need an approximation of backtraces

### This proposal
statistical memory profiler - track a small, representative fraction of allocations.
- lower overhead: tunable sampling rate; relevant info for low sampling rates

Allows you to attach much larger meta-data to blocks that you track.

Implemented in the runtime system
User-chosen OCaml closure is called when sampling a block

Sampling engine uses poisson process (stats)

Uses ephemerons - addition of them to 4.03 has made his memory profiler cleaner

**Comments**
- every allocation can be sampled
- good perf that is also representative

**Future work**
- feedback from users
- better UI

Q: SPJ for the blocks you have sampled, the ephemerons just watch it, and the memory block is not actually changed.

Q: Complimentary with Spacetime (which runs in production)

Q: Able to monitor stubs in C - what would be printed? Last OCaml function called by the stub is printed.

Q: Do you disable sampling when metadata function is running? Yes.

Q: Have you run Spacetime and this on the same codebase? Not yet - happy to try.

Q: SPJ Heap is large, with many things allocated - how did you choose what to focus on (in demo)? I can determine which is allocating at the time. Shows callstack variations.

Q: Can you delimit the callstack using those boundaries? Not supported yet
