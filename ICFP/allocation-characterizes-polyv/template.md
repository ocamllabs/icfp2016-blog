---
title: ICFP 2016: Allocation characterizes polyvariance: A unified methodology for polyvariant control-flow analysis
author: jdjakub (Joel Jakubovic)
abstract: Allocation characterizes polyvariance: A unified methodology for polyvariant control-flow analysis
---

Unify design space of polyvariant techniques

## Monovariance
```
(max 1 2)
(define (max a b) ...)
```

Flow sets equal to num of vars in program.

Call sensitivity: keep call sets distinct wrt var names and histories. Increased complexity but with potential for increased analysis power.

Gambits; trading off complexity for precision in flow analysis.

Standard State-Machine Abstract Interpreter + abstract allocator (could give same address multiple times) + instrumentation (static analysis; tracks info)
Abstract alloc determines polyvariance

Instrumentation encodes context info

A posteriori soundness theorem

## Store-passing Style machine
Control expression, binding env, val store / heap

Unbounded set of concrete addresses, but want fin set of abstract addresses.

## Abstract Abstract machines

Can give abstract allocation the variable we are binding. One big flow set of all reachable values in prog. Dead code eliminator.

# Cartesian-product algorithm

# Object sensitivity
Good for OO languages, dynamic dispatch, etc.

# Are we cheating? How do we know it's sound?
Might and Manolious (2009)

Galois connection!

Q: Can we push this forward, map all address to same address to make program using immutable structs to one using mutable structs?w
A: Yeah, I think it should be possible to distinguish between mutable and immutable data. Not sure what heuristic would give good tradeoff, sounds interesting.

Q: Seems similar to making abstract alloc a monadic computation. Parallel with monads?
A: There is a paper that may address this.
