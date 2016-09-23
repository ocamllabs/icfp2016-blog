---
title: Lock-free programming for the masses
author: avsm (Anil Madhavapeddy)
abstract: Friday 23rd 1105-1130 AM (OCaml 2016)
---

Many lock free data structures available, but they are often not composable.
For example, if a developer has a library that provides `push` and `pop`, they
will need to extend it with `pop_push` if they want to do that atomically.

How can we build composable and scalable libraries? Answer could be "Reagents"
by Aaron Turon in his PLDI 2012 paper. The nice thing about the library is that
learnt from some interesting recent developments: Sequential like STM, Parallel
like Join Calculus and Selective like Concurrent ML.

Normal lambda is:
```
Value 'a -> 'b
Composition: ('a -> 'b) -> ('b -> 'c) -> 'a -> 'c
Application ('a -> 'b) -> 'a -> 'b
```

Reagent can do both refs and channels with similar sigs:

```
module type Reagents = sig
  type ('a,'b) t
  module Ref : Ref.S
    with type ('a,'b) reagent = ('a,'b) t
  module Channel : Channel.S
    with type ('a,'b) reagent = ('a,'b) t
``` 

Channels provide a `swap` primitive for atomic exchange. References do not
allow direct updates to reference. Instead there is a function passed to `upd`:

```
module type Ref = sig
  type 'a ref
  val ref : 'a -> 'a ref
  val upd: 'a ref -> f:('a -> 'b -> ('a -> 'c) option) -> ('b,'c) Reagent.t
end
```

If a protocol returns None, the thread blocks waiting on all the references
internally. As soon as there is a state change (i.e. another ref changes) then
other ones wake up and the protocol continues. This is very similar to the GHC
`retry` primitive.

```
module Treiber_stack = struct
  type 'a t = 'a list Ref.ref
  let create () = Ref.ref [] 
  let push s = Ref.upd s (fun xs s -> Some (x::xs,()))
  let pop s = Ref.upd s (fun l () ->
    match l with
    | [] -> None
    | x::xs -> Some (xs,x))
end
```

If there is no contention then this protocol does only one CAS per push.  For
`pop` the higher order function is applied to the stack, and will block if the
stack is empty (by returning `None`). The new state of the stack is the tail of
the list.  This looks and feels like a sequential stack, and there is no need
for the programmer to worry about retries and backoff. There is also no mention
of threads (wait/notify) in this abstraction, but you get the same blocking
behaviour.

Several combinators to provide the expressive capability...
* Transfer elements atomically via `S.pop s1 >>> S.push s2`
* Consume elements atomically

Can also transform any arbitrary blocking reagent to a non blocking on.

```
val lift: ('a -> 'b) -> ('a,'b) t
val constant : 'a -> ('b,'a) t

let attempt = r >>> lift (fun x -> Some x) <+> (constant None)
let try_pop stack = attempt (pop_stack)
```

This shows how composable reagents are..

Can also efficiently solve dining philosophers problem.

```
type fork = {
  drop: (unit, unit) endpoint;
  take: unit,unit endpoint 
}
let mk_fork () =
 let drop, take = mk_chan () in
 {drop; take}
let drop f = swap f.drop
let take f = swap f.take

let eat l_fork r_fork =
  run (take l_fork) <*> (take r_fork)
```

Composition accumulates CASes, and then if we fail on a k-CAS attempt then it
means that we have active contention from other threads. Then the runtime goes
back and runs the whole protocol if this happens. We can also use HTM to
perform k-CAS, and we have promising early results with Intel TSX!

Performance: busy-poll, lock and variable condition and then channel and
treiber stack are much better.

## Comparison to STM

STM is both more and less expressive. Reagents are STM + synchronous
communication, and there are no RMW guarantees in Reagents. If a Reagent
performs a CAS on the same memory location, the implementation cannot make forward progress.

## Q&A

Q: Programming with arrows is a bit annoying with all the lifting. What is it like in practise?
A: We have PPX syntax rewriters for monads but nothing for arrows but its possible. The fact that they are arrows helps us, since every protocol has one compare and swap instead of a k-CAS.  Dont want to shift to monads despite nicer syntax since thats solvable for arrows directly.

Q: can this be used to build wait free data structures?
A: not sure as the composability results will apply to wait free structures. Tim Harris' results apply for k-CAS, if there is similar result for wait free then it may be possible.
