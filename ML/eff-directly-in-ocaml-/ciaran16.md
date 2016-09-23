---
title: Eff directly in OCaml
author: ciaran16 (Ciaran Lawlor)
abstract: Thursday 22nd 1400-1425 PM (ML 2016)
---

There is a compiler from Eff into OCaml, but instead we can embed effects into OCaml directly (with slightly different syntax). OCaml becomes an Eff implementation.

Also includes dynamic effects / higher-order effects. We realised these can themselves be managed using effects as well.

Eff example for non-determinism and backtracking, with `choose` and `fail` operations - (Note: Eff uses the `#` syntax). We can define handlers to find a solution, or to find and concat all solutions. Nested handlers can also be used.

We can do this directly in OCaml.

Operations become a variant type (`Choose | Fail`).

In Eff handlers are deep - they automatically apply to continuations. In OCaml they are shallow - handlers must be applied to the continuations.

Dynamic effects - creating effects at run time. For example having reference cells of an arbitrary type as a state effect. This has proven tricky. However creating a new instance and handling it can be managed using ordinary effects?

Performance - similar performance as the native compiler for Eff (which took years to develop). Multicore OCaml version is very fast, in fact similar to not using effects?

Since been implemented in F#.
