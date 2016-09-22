---
title: Compiling Links effect handlers to the OCaml backend
author: your-uid-here (your-name-here)
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


