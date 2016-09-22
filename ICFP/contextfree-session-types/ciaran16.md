---
title: Context-free session types
author: ciaran16 (Ciaran Lawlor)
abstract: Wednesday 21st 1555-1620 PM (ICFP 2016)
---

Starting with an example of transmitting lists using session types.

### Streaming a tree

Need to serialize it into a stream of basic data (restricting ourselves to base types), and a deserialize function that can rebuild the tree.

Typing - should guarantee that we can't get things like `Node 5 Leaf` (Ill formed tree) or `Leaf Leaf` (Too many elements).

**Fact** - the trace language of any (first-order) session type is a regular language.

But trees require a context free grammar.

regular - Hardwired sequencing of communication, tail recursive.

context-free - explicit sequencing using `;` and `skip` (e.g. skipping `Leaf`), unrestricted recursion.

### Metatheory

Typing the deserialize function for a tree is non-trivial. Should take a `TreeServer` and return a tree and a depleted stream. But the recursive case has type `TreeServer * 'a * TreeServer`. Need to use polymorphism.

Need some type equivalences in order to do type checking. E.g. Treeserver; skip should be equivalent to TreeServer.

The operators `skip` and `;` form a monoid.

Type equivalence is decidable. T and T' are equivalent if their translations into BPA are bisimulations of each other. And showing bisimulation is decidable.
