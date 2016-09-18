---
title: TyDe 2016: APLicative programming with Naperian Functors
author: yomimono
abstract: APLicative programming with Naperian Functors
---

* arrays can have varying numbers of dimensions, and many functions apply to many ranks of arrays - binary operators included (although sizes must match, so there are some type constraints).
* "a bit more interestingly" there's a "reranking" operator that lets you act on columns, not rows (for a matrix) - is that meaningful for arrays of dimensionality <> 2?
* "the arguments of a binary operator need not have the same rank" - there's implicit promotion to a higher-ranked array. (But other constraints apply once you've done this -- the shapes have to match.)
* "typing rank polymorphism" - paper "an array-oriented language with static rank polymorphism", recent work on [remora](https://github.com/jrslepak/remora) ([discussion](http://lambda-the-ultimate.org/node/5329)) which has static types for shape checking.  Lots of figures... let's make it type-driven! :D
* type definitions for vectors; we'll see lots of definitions for variable-length arrays probably today
* that's not enough for `vreplicate`, though.  [hasochism](http://homepages.inf.ed.ac.uk/slindley/papers/hasochism.pdf) isn't fully needed, because we don't need all of type-level natural numbers; instead, define a class `count` of natural numbers.
* so then the vectors are an applicative functor.  use applicatives as what it means to be a dimension of a matrix (vectors suffice, but so do pairs, or block-structured matriced).  Dimensions can have structure!
* ...but `applicative` isn't enough for `transpose`, which you need for reranking.  The subclass of applicative functors called Naperian functors works, though -- "if all the values of that type have a common shape".  "The class of applicative functors that commute with each other", and that isomorphism means we can use these for `transpose`.
* for things like `sum`, we need `Foldable`; for things like `sums`, we need `Traversable`.
* acceptable array dimensions then are `class (Naperian f, Traversable f) => Dimension f`.
* to make arrays *with* these dimensions, use a nested datatype; then we can do useful promotions nicely
* there are further constraints though - need to index by dimensions, which here is a type-level list (???) I get lost here.
* alignment - "it's the innermost types that should match", "they're alignable if one is a prefix of the other".  need to work out the shortest common prefix for binary operations
* further, it's possible to get a flat representation, which you can shove into a fast GPU backend like Accelerate
* "I don't need to build a hand-rolled type system when I have a sufficiently flexible language whose types already accommodate what I want to do"
