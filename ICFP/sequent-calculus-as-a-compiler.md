---
title: Sequent calculus as a compiler intermediate language
author: OlivierNicole (Olivier Nicole)
abstract: Monday 19th 1405-1430 PM (ICFP 2016)
---

*[Paper PDF](https://www.microsoft.com/en-us/research/wp-content/uploads/2016/04/sequent-calculus-icfp16.pdf)*

Lambda code has been used as an IL in compilers for decade. But another useful
IL is sequent calculus.

# A compiler's job

Turn a source (feature-rich) into machine code (detail-rich). Most of the time,
we need an intermediate language in the middle (e.g. Core in Haskell).

Another way to use lambda calculus is CPS IL: CPS Core = Core - non-tail calls.

# The Sequent Calculus

Natural deduction ~ lambda-calculus: "closer to mathematicians' reasoning"

Sequent calculus: "easier to reason about" ~ ???

The language associated to SC is a language with left-right dichotomy: producers
and consumers. It still has some high-level features such as binding and
substitution.

NB: Gentzen discovered statically-typed call stacks in the 1930s.

The corresponding flow chart would resemble:

~~~
source -----> Core -----> Sequent Core -----> Machine
      desugar    translate         generate code
~~~

Sequent Core contrasts data-flow and control-flow. Computations happen when
computations meet values.

# The two roles of Continuations

## Continuation as Evaluation Contexts

Say what to do with the intermediate results in a program.

## Continuation as Join Points

A common point is where several branches of a control flow join together.

These two notions are very different.

## Evaluation Centexts vs Join Points

"But join points sound a lot like functions!"

They are, but very special functions: always tail-called, don't return; never
escape their scope.

# Implementation in GHC

* Implemented as a GHC plugin
* Use 2-way translation to lift Sequent Core optimizations into Core-to-Core
passes.

# What did Sequent Core teach us?

* "Continuations* serve at least 2 roles
* Sequent Calculus is great at representing negative types (functions)
* Not just intuitionistic: join points are classical feature that can be tamed
for purity
* Go beyond administrative-normal form
* Control flow not just for strict languages; it's great for lazy languages,
too.
