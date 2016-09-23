---
title: Non-recursive make considered harmful: Build systems at scale
author: your-uid-here (your-name-here)
abstract: Friday 23rd 1520-1545 PM (Haskell 2016)
---

GHC build system is currently a non-recursive Make. It has undergone 4 major
rewrites and is distributed among 200 makefiles, representing more than 100 K
lines of code.

The problem is that `make` uses a global namespace of mutable string variables.
What could be worse?

Our solution is to use FP to design scalable abstractions. We use Shake, a
Haskell library for writing build systems.

Shake is more verbose for small build systems, but scales much better.

Sample code:
```
main = runShake shakeOptions $ do
  want [toptarget]

  "*.o" %> \obj -> do
    let src = obj -<.> "c"
    need [src]
    run "gcc" ["-c", src, "-o", obj]
```

The essential complexity to deal with is *computing command lines*.

Our solution to this is an EDSL dedicated to building command-line instructions.

# Evaluation

It is quite faster (10 %) and performs less unnecessary rebuilds.
