---
title: A fully concurrent garbage collector for functional programs on multicore processors
author: your-uid-here (your-name-here)
abstract: Wednesday 21st 1420-1445 PM (ICFP 2016)
---

All abstractions should be implemented on top of native threads. C is doing
this! ML is not.

A major obstacle is stop-the-world GCs. We propose a GC that never interferes
with allocation.

Observation: these can scale up to massively many threads.

Technical point: how to take snapshot without stopping multiple mutators?

Block allocation never incurs contention. And the number of mutators is bound to
the number of segments.  There are no interferences between mutator and
collector.

# Snapshot GC algorithm

1. Start a collection cycle at t0
2. Start a collector thread.
3. Somehow save H(t0)
4. Somehow push R(t0) to the trace stack
5. Other steps…

How to save H(t0)?

1. save H(t0) from memory update
2. save H(t0) from allocation

In our work we use the idea of handshaking [Doligez & Gonthier '94].

The sources of memory contention are only:
1. The set of segments
2. The tracing stack.

See paper for details.

# Performance evaluation

Overhead is 12 % on average.

In terms of speedup, concurrent is comparable to stop-the-world. Speed-up is up
to ×8 whereas we have 16 cores.

# Conclusions

We developed a concurrent collector.
* never stops any mutators
* for functional programs with many threads

