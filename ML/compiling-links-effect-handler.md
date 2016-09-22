---
title: Compiling Links effect handlers to the OCaml backend
author: avsm (Anil Madhavapeddy)
abstract: Thursday 22nd 1425-1450 PM (ML 2016)
---

Speaker has been a grad student for two weeks *audience laughter*

The Links language (Cooper et at 2006) is an ML-like strict language with FP
features, and has three different compilation backends already. An algebraic
effect is a collection of abstract operations, e.g. `Nondet = { Choose: Bool
}`.

Using abstract operations we can define effectful computations abstractly, e.g.

```
sig toss: () { Choose:Bool|e } -> Toss
fun toss () { if (do Choose) Heads else Tails }
```

e is an effect (row) variable, but compiling this blows up since `e` is unhandled.

```
handler randomResult {
  case Return(x) -> x
  case Choose(resume) -> resume(random () > 0.5)
}
```

The function `resume` is the captured delimited continuation of the operation
(can think of it as a restartable exception).

Interpretation of toss with this handler:

```
links> allChoices(toss)();
[Handles, Tails] : [Toss]
```

The effect has been rippled up and the result is random.

This has been built as a backend to OCaml.  The backend uses the Lambda backend of OCaml since it allows the exploration of both the native and bytecode bckend.  Multicore OCaml provides effect handlers as an abstraction for concurrency, an efficient native implementation of linear effets (one shot continuations) and an explicit copying construct for on demand multi-shot handlers.

The important restriction is that continuations have to be one-shot in OCaml and an exception is raised if it is called more than once.  This for performance reasons in the memory representation.

A performance graphs shows that an Lwt based version (an interpreter) outperforms the compiler, which is problematic. Idea is to use the linear type system of Links to track the lifetime of handlers and then use that to optimise outputs.

Can we use the effect system to propagate linearity information?  Ideally we want to know when we need a multishot effect _vs_ a single shot effect to same lot of time.

The linear type system is not quite enough to capture tombstones.  For instance, if we have two channels that are both listening on a value P.

Author is the first external user of multicore OCaml!

## Q&A

Q: Do you need multishot continuations in Links?
A: They are useful for backtracking computations, and so envisions using them in transactions in databases.  But would be nice to not depend on them massively.

Q: What extensions to linear typing systems are needed?
A: missed answer

Q: can we mix OCaml and Links in same program?
A: Yes! 

Q: can call OCaml from Links and not the other way around right? This would break invariants in OCaml
A: *discussion ensues, rough consensus being that linearity in OCaml might also be needed*
