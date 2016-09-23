---
title: ICFP 2016: Constructive Galois connections: Taming the Galois connection framework for mechanized metatheory
author: jdjakub (Joel Jakubovic)
abstract: Constructive Galois connections: Taming the Galois connection framework for mechanized metatheory
---

Designing a new static analyzer. Abstract interpretation: gives spec for static analysis to be sound
Calculational design method: fuse proof and implementation process -> reach bug in proof, exactly where you need to fix implementation
Proof assistant

Abstract interpretation:  synthesized spec, correct by construction, ???

Ability to calc while being mechanizable.

if (b) {x=10} else {x=29}

Semantics: x \in {10,20} (undecidable properties)
Static analysis: x \in {10,20} (overspecified but decidable)

Direct verification can't calculate
Abstract interpretation can't mechanize
Kleisli GCs calculate and sorta mechanize
???

direct version example:

```
succ : N -> N

flip : Prediction -> Prediction
flip Even = Odd
flip Odd = Even
```

is flip optimal???
can it be derived from succ??

Concrete semantics / domain LHS, abs RHS

Galois conn cat theory abstract nonsense
```
\alpha : conc -> abs
\gamma : abs -> conc
```

abstract interpretation reqs axioms, and lifting everywhere.

Kleisli inspiration for the solution.

Drop into a monadic space

They don't compute

Constructive GCs
