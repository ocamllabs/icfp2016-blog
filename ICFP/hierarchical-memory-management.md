---
title: Hierarchical memory management for parallel programs
author: your-uid-here (your-name-here)
abstract: Wednesday 21st 1330-1355 PM (ICFP 2016)
---

# A Fundamental Property

In purely functional programs, pointers always point up the heap hierarchy. We
call this property *disentanglement*.

# Enforcing Disentanglement

* A path P is a stack of heaps from a local expression up to the root.
* Restrict heap accesses to heaps in the path.

If lookup never fails, then disentanglement holds.

If type safety for lambda_HP then disentanglement and memory safety hold as
corollaries.

# Implementation

## Scheduling

* We use a work-stealing scheduler that allows tasks to fork new tasks onto a
queue tand idle processors to steal tasks from other processor queues.

## Superheaps

* Creating heaps is expensive, so defer them to steals.

## Superheap structure

* Superheaps hold allocations from multiple directly descendant tasks.
* A new superheaps is used for stolen tasks.

* Memory is split into "levels".
* A level is activated when the corresponding task is stolen by another
processor.
* Disentanglement holds between levels.

## Local collection

* Local collection is done bottom-up, level-by-level in a single superheap up to
the lowest activated level.
* Disentanglement ensures that a level will not have to be revisited once
complete.

# Evaluation Design

Does well except on a raytracer benchmark where it's beaten by its competitor
`manticore`.

# Conclusion

* Closely couple memory manager to program.
* Proved memory safety.
* Implementation shows promising performance.

See paper for:

* Proof of semantics preservation.
* Discussion of practical design.
* Analysis of benchmarks.

Future work:

* Support for other forms of parallelism.
* Support some form of mutable state.
* Develop a more mature implementation that implements non-local collection in
addition to local collection.
