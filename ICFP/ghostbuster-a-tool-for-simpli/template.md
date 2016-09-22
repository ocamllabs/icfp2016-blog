---
title: ICFP 2016: Ghostbuster: A tool for simplifying and converting GADTs
author: jdjakub (Joel Jakubovic)
abstract: Ghostbuster: A tool for simplifying and converting GADTs
---

"We ought to be teaching our students parallelism form the very start!"

"Use Accelerate as a vehicle to teach about eg GPUs?"

Regular list GADT, simply typed.

Head of empty list -> runtime error. Compiler didn't catch it.

Move to type-indexed representation, `Vect n a`. Now, compiler can tell.

However, difficult to make changes as have to fulfill type obligations. No rapid prototyping. Missing compiler features, error messages...

Prototype in regular ADT? Threw away type invariants! And need to somehow reestablish when moving back to GADTs.

So this work focuses on switching between these GADT/ADT reps.

Option 1: Do it manually. Adds live maintenance burden...
Option 2: Runtime eval - take simply typed data structure, then generate GADT string using GHC for *runtime overhead* also *stringly typed*
Option 3: How do we do `List a` <-> `Vect n a`??

Begin with GADT. "Ghostbuster, please erase type var n, leaving just a"

```
data Vect a where
 VNil' : Vec' a
 VCons' : a -> Vec' a -> Vec' a
```

Can't erase a, but can 'check' it. Existentially quantified.

Once erased type info ... how to recover? Consider length as the output of conversion function. Determined by structure of list.

`downList : List' -> Maybe (List a)`

So the point is to incrementalize engineering costs of GADTs, by converting between simply and type indexed datatypes.

Q: About `downVec`, could be Vec 3, Vec 7, Vec 12, ??
A: You have to tell the type checker "I know what length this is"

Q: Did you have any intuition about Agda where you could include function calls in indexed positions as well as ordinary values?
A: No, sounds interesting.

Q: If you took `upVec` of `downVec` of `v` then would it not be able to figure out how long the vector is?
A: Yes, I suppose it depends on your use case.
