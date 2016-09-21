---
title: The best of both worlds: Linear functional programming without compromise
author: OlivierNicole (Olivier Nicole)
abstract: Wednesday 21st 1530-1555 PM (ICFP 2016)
---

Let's put linear types and functional programming together and see what happens!

* Types distinguish whether functions can be copied or discarded
* Central problem: generic combinator programming with multiple function types.
This is why we are not programming in linear functional languages today.

We introduce a Qualified Linear Language.

# Linearity and overloading

```
\x -> x + x
```

* Type of x must be numeric and unrestricted.

```
\x -> let (y,z) = dup x in y + z
```

* Unrestricted types have methods:
  ```
  dup :: t -> t × t
  drop :: t -> 1
  ```
* Corresponds to interpretation of exponential modality via a commutative monoid
  (Filinsky, Seely)

# See in the paper

* Session types
* Monads

Metatheory:
* Principal types and type inference
* Type safety
* Conservative extension of existing functional languages

Prototype implementation… coming very soon.

