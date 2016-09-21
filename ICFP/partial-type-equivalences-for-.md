---
title: Partial type equivalences for verified dependent interoperability
author: ciaran16 (Ciaran Lawlor)
abstract: Tuesday 20th 1555-1620 PM (ICFP 2016)
---

Dependently typed programs often have to interact with simply typed or untyped programs (system calls, libraries). The dependent interoperability framework trades static guarantees for run-time checks. Our framework is developed in Coq.

### Use cases

- Use simply-typed library in dependently-typed context
- Use dependently-typed library in simply-typed context
- Dynamic verification of simply-typed components
- Safe(r) extractions of dependently typed programs

### Partial Type Equivalences

Formal, constructive foundations of dependent interoperability.

By proving first-order equivalences you get higher-order equivalences verified for free.

E.g. vector and list are not fully equivalent. But they have partial type equivalence. By proving this we get verification that  functions over lists and vectors are equivalent.
