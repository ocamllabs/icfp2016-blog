---
title: ML 2016: Classes for the masses
author: jdjakub (Joel Jakubovic)
abstract: Classes for the masses
---

This talk is about a cheap trick for implementing typeclasses in .NET. Back in 2005, PL competition, Haskell came out top (generic programming).

Typeclasses have proven to be very productive. Many languages have pinched them. But not F#.

Nice cheap coding trick that is:
type preserving - no yucky erasure
efficient
free
modular (separately compile typeclass decls from instance decls)

Call them traits (concepts in C#)

OOP languages have interfaces - declare class, anticipate which interfaces to implement. Typeclasses have fewer indirections, more lightweight. Want efficient way to abstract over numeric types in F#.

```
class Eq a where
  (==) : a -> a -> Bool
```

```
type Eq<'A> = interface
  abstract equal : 'A -> 'A -> Bool
end
```

```
[Trait]
type Eq<'A> =
  abstract equal : 'A -> 'A -> Bool
```

Haskell has `eq : (Eq a) => a -> a -> Bool`

```
let equal<'A,'EqA when 'EqA : struct and 'EqA :> Eq<'A>> a b =
  defaultof<'EqA>.equal a b
```

Type param 'EqA constrained to be struct (stack alloc), bounded by its interface, and a named witness for its constraint.

Implement Haskell instances as F# structs implementing the trait / interface.

One reason Haskell is so good is that you can use the type system to write so much code for you.
