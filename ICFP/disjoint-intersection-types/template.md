---
title: ICFP 2016: Disjoint intersection types
author: jdjakub (Joel Jakubovic)
abstract: Disjoint intersection types
---

A solution to the coherence problem

Dunfield (ICFP 2012): intersection types and term-level merges in lambda calc

A&B:

let x : Int & Bool
...
(succ x, not x) : Int * Bool

eg x = 1 ,, True (called 'merge')

(\x.x : String -> String)(1,,"one")

Subtype relation between intersection types. Int & String <= String.

Like pairing, except implicit elimination and no ordering.

Coherent if any valid prog has only one meaning

Forbid overlapping types? What about function types?

Two types disjoin if do not share common super.
(Int -> Int) and (String -> String) disjoint
(Int -> String) and (Int&String -> String) we have Int < Int&String

Disjointness not enough to ensure coherence

eg ((succ,,not) : Int -> Int) (3,,True)

Disjointness + bidirectional type checking

Theorem of unique elaboration: exists unique elaboration result.
Simple syntax with A->B, AxB, A&B
require intersection and merges to be disjoint. prevents incoherence

(\(x:Int). x+1)(1,,2)

Int&Int < Int or ??? (multiple meanings!)

Two types of overlap; require some type in the induction rules to be 'ordinary' ie contain no intersection

Disjoint def not algorithmic ... how to implement? Exist equivalent sound, complete ruleset.

Q: What do you gain from intersection rather than records?
A: Intersection is more general

Q: Have you thought about what would be needed to get this dependently typed?
A: I suppose so, could investigate.

Q: Do we really want to do it / need it? Are there programs that would be much more convenient to write?
A: Yes - this is about reducing boilerplate, if you want to extend / change the types for example
