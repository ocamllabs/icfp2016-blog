---
title: Think like a vertex, behave like a function! A functional DSL for vertex-centric big graph processing
author: your-uid-here (your-name-here)
abstract: Tuesday 20th 1125-1150 AM (ICFP 2016)
---

## Example: reachability problem

Iterative supersteps (superstep = computation on every vertex in parallel).

Is v_0 reachable?
* if I am v_0, I am reachable;
* if one of my neighbours is reachable, then so am I.

Problem 1: what is computed?
Problem 2: when does it terminate?

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

## Our Function DSL 'Fregel'

It's a 1st-order functional language with some G-HOF (graph higher-order
functions). It's compiled to Fregel.

## Experiments results

* Scales well similarly to hand-written code
* SSSP runs at ×10 slow speed, while DS at ×2 slow speed.

More details are available in the paper.

## Conclusion

Our DSL for big-graph processing provides better programmability. It achieves
good performance without optimization, but we nevertheless need to implement
various optimizations.
