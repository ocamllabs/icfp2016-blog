---
title: Eff directly in OCaml 
author: your-uid-here (your-name-here)
abstract: Thursday 22nd 1400-1425 PM (ML 2016)
---

There is an idiomatic embedding of Eff into OCaml. Not just compilation.  OCaml becomes another Eff implementation!
There are two backends using delimcc and OCaml effects.  We can also create dynamic effects.

the `effect` declaration describes nondeterminism:

```
type 'a nondeterminism = effect
  fail: unit -> empty
  choose : ('a * 'a) -> 'a
  cow : 'a -> 'a
end
```

and can be used with a similar syntax to objects:

```
let x = r#choose ("a","b") in
print_string x;
let y = r#choose ("c", "d") in
print_string y;
```

handlers get more interesting since they let code pattern match on the handlers (like exceptions):

```
let p = new nondeterminism in
handle
  let a = p#choose (1,2) in
  handle
    let b = p#choose (10,20) in
    let c = p#cow 3 in
    (a,b,c)
  with
  | val v -> [v]
  | p#cow x k -> k (3*x)
  | p#choose (x,y) k -> k x @ k y
```

with delimcc, we use shift0 and reset to build up the exception chain to support the implementation of handlers.

## Static and dynamic effects

```
type 'a state =
  | Get of unit * ('a -> 'a state result)
  | Put of 'a * (unit -> 'a state result)
let rec handler ref s res = function
  | Done -> get_result res
  | Eff Get (_,k) -> handler_Ref s res @@ k s 
  | Eff Put (s,k) -> handler_ref s res @@ k ()
```

Can we use the same handler to create an arbitrary number of state calls? Many state effects of many types, for example dynamically in a loop.
In other words, `newref` means:

... let r = newref s in ...

```
handle_it r (fun () ->
 ... let r = new_prompt () in
handle_ref s
```

More than just a local transformation, and Eff removed it in Eff 3.1 since it
introduced code incompatibilities but needs a major rev to language.  Higher
order effect is something that creates a new instance and handles it as an
ordinary effect.

Performance is awesome when compiling to OCaml with effects is awesome compared to Eff.

Eff also implemented using this technique in F# using [computational expressions]().

The OCaml eff embedding is a simple local translation, and almost cutting and
pasting Eff into OCaml with excellent performance.

## Q&A

*Q:* What is the purpose of `cow`
A: Just to add an effectful operation that takes just 1 argument since the others were 2/3 args.  Sam observes that `cow` is what Agda uses instead of `foo`.

Q: Good performance, but its 14 times slower. So its as good as Eff which is not very good.
A: Multicore OCaml version is fast and is a translation into multicore ocaml via translation. Uses a single core still, just needs the primitives from multicore (e.g. fibres).
