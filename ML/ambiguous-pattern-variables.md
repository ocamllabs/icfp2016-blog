---
title: Ambiguous pattern variables
author: avsm (Anil Madhavapeddy)
abstract: Thursday 22nd 1655-1720 PM (ML 2016)
---

Joint work with Luc Maranget and Thomas Refis.

```
type 'a exp =
  | Const of 'a
  | Mul of 'a exp * 'a exp

let is_neutral n = (n=1)

let mul a b = match a,b with
| (Const n,v) | (v, Const n) 
  when is_neutral n -> v
| a, b -> Mul (a,b)
```

if you do

```
mul (Const 2) (Const 1) = Mul (Const 2, Const 1)
```

instead of the expected `Const 1`.  The reason is that in a pattern match `p| q` is
left to right and only then is the guard tried.  It is not the case that
the guard g will test both expressions.  

Automatically turning this into `(p when g) | (q when g)` also doesnt work
since it breaks existing semantics.  Also breaks nested guards to do this and
side-effects in the guard would be duplicated.   Generally speaking there are
too many corner cases to simply change OCaml to repeat the guard evaluation.

Instead we would rather warn about it when:
* a value may match `p` in several ways (or patterns)
* the test `g` may depend on which choice is taken -- i.e. it contains ambiguous pattern variables.  It also tells you the manual section to refer to!

How to implement this warning?  As for all pattern matching questions (compilation, exhaustivity, usefulness), there is now an algorithm called *pattern matrices* which are a cool new algorithm to generally reason about ML pattern matching .

A matrix: a space of matcheable values that share a common prefix.
* rows: disjunction, alternative
* columns: sub-patterns matched in parallel
* contexts: common prefix, possibly different bindings

## Q&A

*Q:* Its a matrix but there is a context on the side so why is it a matrix
*A:* when you manipulate it you pretend the context doesnt exist

