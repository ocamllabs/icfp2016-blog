---
title: Datafun: A functional datalog
author: OlivierNicole (Olivier Nicole)
abstract: Tuesday 20th 1150-1215 AM (ICFP 2016)
---

Datafun is:
* a simply-typed lambda-calculus
* where types are posets & some are semilattices
* that tracks monoticity via types
* to let you compute fixed points
* and know they terminate.

# Tracking monotonicity

* Two types of function: discrete or monotone
* Two kinds of variable: discrete or monotone
* Two typing contexts: Delta discrete, Gamma monotone.

## Fixed points

### Example of CYK parsing

The CYK parsing algorithm (to parse a context-free grammar) translates very
easily into Datafun.

## Conclusion

Many algorithms are concisely expressed as fixed points of monotone maps on
semilattices. Tracking monotonicity is very useful.

Datafun can be seen as a generalization of Datalog because it supports
other semilattices.
