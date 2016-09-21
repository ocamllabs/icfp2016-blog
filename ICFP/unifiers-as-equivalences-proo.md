---
title: Unifiers as equivalences: proof relevant unification of dependently typed data
author: ciaran16 (Ciaran Lawlor)
abstract: Tuesday 20th 1505-1620 PM (ICFP 2016)
---

Agda uses unification to eliminate impossible cases and specialise the result type.

The output of unification can change Agda's notion of equality.

Flavors of type theory - Classical, Homotopy Type Theory, Syntactic

We want something that works for all flavors. A purely syntactic algorithm won't work.

**Core idea** - unification should return evidence of unification in the form of an equivalence.

### Unifiers as equivalences

A *unification problem* consists of a context of free variables, and equations.

This can be represented as a *telescope*. "A telescope is a list of types where each type can depend on values of the previous types. Each type in this telescope corresponds to one equation of the unification problem." (from the paper)

A *unifier* consists of a reduced context and a substitution.

This can be represented as a *telescope map*.

A *most general unifier* is one such that any other unifier can be composed from the most general unifier.

A most general unifier is an equivalence between telescopes.

### Proof-relevant unification

? rule

Deletion rule (requires uniqueness of identity proofs)

Conflict rule

Cycle rule

### Depending on equations

???

Telescopic equality - Solution: keep track of dependencies by introducing a new variable for each equation.

### Conclusion

We have a new definition of the most general unifier internal to the type theory that is correct by construction and can be used to compile pattern matching to eliminators.
