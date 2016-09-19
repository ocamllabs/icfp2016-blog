---
title: Program transformations for developing efficient and correct programs with ease
author: OlivierNicole (Olivier Nicole)
abstract: Sunday 18th 1530-1600 PM (PLMW 2016)
---

You can start from an inefficient program (e.g. naive list reversal) and, via a
program transformation, make it efficient. For example, applying deforestation
(Wadler, '90) to the naive reversal gives the efficient version.

More generally, program transformation can be used make intuitively written
programs more efficient, invert programs (e.g. turn a pretty-printer into a
parser) or do partial evaluation (e.g. transform an interpreter into a
compiler).

## Transformation examples

Problem: calculate the maximum of prefix sums. An immediate, intuitive solution
is: `mps x = maximum (map sum (inits x))`. Can we make it more efficient?

In this program, `map` produces lists but `maximum actually consumes sets. This
observation lets us write a more efficient version.

Two important techniques are deforestation and tupling.

## Conclusion

Program transformations are very useful to develop complex programs. They can be
used as a guide to develop such programs. The step from intuitive programs to
efficient programs can be made in a correct-by-construction manner.

Topics not discussed in this talk:
* automation of transformations
* formalization of generic transformation rules
* correctness / effectiveness of transformations
