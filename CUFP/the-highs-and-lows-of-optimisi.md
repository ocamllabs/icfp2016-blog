---
title: The Highs and Lows of Optimising DSLs
author: seliopou (Spiros Eliopoulos)
abstract: Saturday 24th 1425-1450 PM (CUFP 2016)
---

Using DSLs are motivated by the need for expressiveness, correctness, and performance. Icicle is a query language time-series data that uses a modal type system to ensure that data points are inspected only once. The langauge is a pure and total language.
 
# Scheme specialization                                                                                 

Being I/O bound is soooo 1996. Parsing performance matters. Use information about your serialization format to write highly-specialized parsers to optimize the load time of your DSL, and look into functions such as `memchr(3)` to scan multiple bytes at a time.

# Partial Evaluation

The icicle language supports abstraction through lambda terms. The compiler employs `beta reduction` to elimiate as many lambdas as possible to avoid having to generate C code for those lambdas. Constant folding is also employed to eliminate expressions that only involve constants. For example, if the expression `9 + 1` appears in the source langauge, it will be reduced to `10` before core generation. These two optimization, together with aggressive (exhaustive?) inling, eliminates all the lambdas in the program.

# Data flattening

> "There is nothing in this world that will motivate you more to write code than the threat of migrating to C++"

```
data Price =
    { open : int
    , high : int
    , low : int
    }
``` 

Gets transformed by a "melting" operation to three variables:

```
open : int
high : int
low: int
```

The type `Option Price` would be turned into four variables

```
is_just : bool
open : int
high : int
low: int
```

Finally, the type `Array (Option Price)` would be turned into these four variables:

```
is_just: array bool
open: array int
high: array int
low: array int
```
