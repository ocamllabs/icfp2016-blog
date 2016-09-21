---
title: Think like a vertex, behave like a function! A functional DSL for vertex-centric big graph processing
author: OlivierNicole (Olivier Nicole), ciaran16 (Ciaran Lawlor)
abstract: Tuesday 20th 1125-1150 AM (ICFP 2016)
---

Vertex centric computation is being used for Large-scale graph processing ("Think like a vertex"). But this is imperative. Iterative supersteps (superstep = computation on every vertex in parallel).

Fregel - a functional approach to vertex centric computation that can be automatically translated into Pregel, an imperative equivalent.

## Example: reachability problem

Is v_0 reachable?
* if I am v_0, I am reachable;
* if one of my neighbours is reachable, then so am I.

Programmability problems in Pregel code:
- **Message-pushing** - function generating a new value by directly reading previous values.
- **Termination at different points** in the imperative code - composition of main computation and terminator.

## Basic functional ideas

### Problem 1

Message-pushing replaced by a function generating a new value by reading
previous values.

```
step v prev = prev v
  || or [ prev u | u <- nbrs v ]
```

### Problem 2

Composition of main comp. and terminator.

## Our Functional DSL 'Fregel'

It's a 1st-order functional language with some G-HOF (graph higher-order
functions). It's compiled to Pregel.

Read-based access through a table - message-pushing style is difficult to understand, read-based access makes it easy to see what is computed.

Infinite sequence of graphs and terminator - easy to see when it terminates.

## Experiment results

* Scales well similarly to hand-written code
* SSSP (Single-source shortest path) runs at ×10 slow speed, while DS (Densest subgraph) at ×2 slow speed.

More details are available in the paper.

## Conclusion

Our DSL for big-graph processing provides better programmability. It achieves
good performance without optimization, but we nevertheless need to implement
various optimizations.

## Future work

Various optimisations (cancellation of sending redundant messages, reduction of number of supersteps)

Extension of the language (support for changing the shape of the graph, update of edge values, nested comprehensions)

## Questions

Q: Is Fregel fully deterministic?

A: Yes, it always returns the same graph for the same input.

Q: Fregel uses global termination while Pregel uses local termination. I wonder how much this limits parallelism?

A: This requires more optimisation, this is future work.
