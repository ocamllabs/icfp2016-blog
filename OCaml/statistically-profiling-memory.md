---
title: Statistically profiling memory in OCaml
author: your-uid-here (your-name-here)
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
