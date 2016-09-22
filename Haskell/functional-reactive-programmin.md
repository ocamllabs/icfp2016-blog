---
title: Functional reactive programming, refactored
author: your-uid-here (your-name-here)
abstract: Thursday 22nd 1100-1125 AM (Haskell 2016)
---

What is FRP? FRP is about meaning, without regarding how you sample it, how it
is calculated. It's a simple, denotational model to describe
(continuous-)time-varying systems.

If we look too far back in the past, we have to remember that past, i.e. keep it
in memory.

The other problem emerges when we try to access something in the future. If we
want to access the value of `y` in three years, we need to *wait* 3 years.

Everyone is confused: designers, researchers and developers alike.

What we want is not yet another FRP implementation: we want a unified framework.

# Yampa

Yampa addresses the 2 problems mentioned above. It is causal and efficient.

Problem: when there's a problem in the "circuit", you can't do IO (Signal
Functions are pure). You can't use `trace`, nor `print`. So you have to change
the type of an arrow, which in turns forces to change the type of the whole
circuit.

Another limitation is that you have no control over time itself.

# Stream functions

```
type MSF m a b = a -> m (b, MSF m a b)
```

* `m` is a monad
* `MSF m` is an arrow.

Note that there is no time here.

# Basic combinators

```
arr :: (a -> b) -> MSF m a b
liftS :: (a -> m b) -> MSF m a b
```

We also have sequencing (`>>>`). NB: side effects occur in order!

# Behold the power of the monad: Writer monad

Enables us to do debugging.

```
debugEvenWriter :: MSF (WriterT [String] m) Int Bool
debugEvenWriter = liftS $ do
  when (x < 0) $ tell "Tie"
  return (even x)
```

To escape the Maybe monads, we provide `catchM`. This implements dynamic
transformations, but is NOT a primitive in our library!

Yampa can just be implemented as such:
```
type SF a b = DTime -> a -> (b, SF a b)
-- becomes
type SF a b = MSF (Reader DTime) a
```

# Also in the paper…

* Superseeding Yampa by adding a monad parameter to signal functions
* Other frameworks are "subsets" of MSFs:
** Reactive Programming
** Classic FRP
** Push-based FRP
