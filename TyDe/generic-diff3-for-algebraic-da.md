---
title: Generic diff3 for algebraic datatypes
author: OlivierNicole (Olivier Nicole)
abstract: Sunday 18th 1045-1115 AM (TyDe 2016)
---

[preprint pdf in ACM Digital Library](http://dl.acm.org/citation.cfm?id=2976026)

The objective is to generalize diffs to algebraic data. The introductory example
is a situation where 2 contributors try to modify a table at the same time:
there can be merging conflicts even if they modified separated sets of cells.

If the diff3 algorithm knew about cells (rather than just trying to merge
lines), then many conflicts (e.g. for changes on rows) could be avoided.

The author proposes a generic diff3 algorithm with the following
characteristics:
* Algebraic Data Types
* Typed Rose trees
* Fine-grained
* Formal Semantics

The nature of edit scripts changes: while UNIX diff3 uses `delete`, insert and
copy, we will use mapping.

The goal is to properly formalize a 3-way merge operator for tree-like data
structures.

What happens if there is no source node for a mapping (i.e. pure insertion)? The
idea is to go back to mapping by adding a "dummy" node to the original tree.

## A Statically-Typed Algoritm

We don't want the algorithm to produce ill-typed results, even though there may
be no merge conflicts.

## Questions

Q: The aligning algorithm is too supple. For example, merging `[1] -> [2]` and
`[1] -> [1, 1]` the answer is not unique: two valid merges are `[2, 1]` and `[1,
2]`.

A:

When doing `[1,1] -> [1,1,1]`, how do you distinguish between prepending and
appending.

A: it is about minimizing the size of the edit script.

