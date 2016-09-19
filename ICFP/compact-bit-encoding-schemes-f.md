---
title: Compact bit encoding schemes for simply-typed lambda-terms
author: ciaran16 (Ciaran Lawlor)
abstract: Monday 19th 1700-1725 PM (ICFP 2016)
---

Presenting two types of encoding schemes - tagless coding and grammar based coding.

Why bit encoding? Higher-order data compression. Theoretically optimal up to an additive constant.

Previous bit encoding schemes are not compact enough.

### Tagless Coding

lambda term -> sequence of symbols -> bit code

Need to know how to convert lambda terms into a sequence of symbols. A simple way would be to use the string of the lambda term? A slightly better idea is to have a sequence of the types of each variable, and a sequence of the variables. The original lambda term can be recovered from this.

(I am lost) Examples, Showing Correctness

Experiments show that tagless works better than previous encoding schemes.

Compared to a bit encoder for grammar-based compression, tagless coding worked better some of the time, and for other benchmarks the tagless coding had about 10% more overhead. This is likely due to the limitations of tagless encoding.

Some of the limitations:
- Different bit codes are assigned to equivalent (but different) lambda terms.
- Bit codes are assigned to invalid sequences.

### Grammar based Coding

lambda term -> derivation sequence based on CFG of ? -> bit code

So first we need to generate the CFG, then use arithmetic coding of the CFG to produce bit codes.

Now we can assign the same bit code to equivalent terms (as far as possible) by preparing 'normalization' rules and restricting the CFG so only 'normalized' terms can be generated. And bit codes cannot be assigned to invalid sequences anymore? So this solves the limitations of tagless coding.

Experiments - comparison with previous encodings show that it is almost as good as a CFG specific encoding.

### Future work

Applications other than higher-order data compression

A more efficient implementation for grammar based coding.
