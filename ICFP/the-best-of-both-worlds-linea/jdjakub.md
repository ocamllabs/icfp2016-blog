---
title: ICFP 2016: The best of both worlds: Linear functional programming without compromise
author: whoami (Anonymous)
abstract: The best of both worlds: Linear functional programming without compromise
---

Why does nobody use langs with linear types? Surely it makes perfect sense?

Simple K combinator example. Types tell whether funcs can be copied or not

Introduce Qualified Lin Lang. Use predicates on types.

"Lightweight types in System F", "Practical Affine Types"

dup : t -> t MULCONJ t
drop : t -> 1
\(f,x).f x

Qualified types

Q: Compare this to polymorphism for uniqueness types?
A: Different because of how exposed in lang, affecting abstrcs. Linearity is prescriptive, can't fall back on non-unique intrp for eg monads.

Q: Could it please be extended with dependent types?
A: Probably, haven't looked at it.
