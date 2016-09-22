---
title: Making reactive programs function
author: your-uid-here (your-name-here)
abstract: Thursday 22nd 0915-1015 AM (ML 2016)
---

We say ML is a functional language, but it supports horrible things like this
(*gives an example with mutable-state-based recursion*).

ML supports pointers and pointers to code that can be dynamically modified.

The speaker will try to argue that this is actually *a good thing*.

When Adobe surveyed their bug reports, they found that most of them were due to
UI. That is, UI is tougher than highly sophisticated image processing!

Example of how it can get wrong: we rely on our browser toolbar to ensure that a
connection is secure…

# What makes GUI programs hard

GUI is just the programmers installing callbacks in a table.

# FRP

Functional Reactive Programming views dynamically-varying state as streams.

# Trouble in Paradise 1: Causality

Example code given:
```
trade : S prices -> S order
trade prices =
if today_price < tomorrow_price
  (* ... *)
```

## Possible fix: Causality via Types

Add `°A`, the type of "As tomorrow" or "next A" and change the types of
constants. But this implies to change the type of the fixpoint operator to
`(°A -> A) -> A`.

Now we have well-founded, deterministic higher-order stream programming.

# Trouble in Paradise 2: Space Leaks

```
const : S N -> S (S N)
const ns =
  cons (ns, const ns)
```

The first values of the stream have to be retained in memory, hence a memory
leak.

## Possible Fix

Add "box A", the type of "stable A" or "always A". E.g. All elements of `N` are
stable, but no elements of `S N` are stable. Some elements of `A -> B` are
stable.

A fine program then is:
```
const : boxA -> S A
const box(a) =
  cons (a, const box(a))
```

This can be called if `A` = `N`, but not if `A` = `S N`. Problem solved!

# How to implement it

Idea: `°A` are pointers to code.

* Force the thunk on the tick it is scheduled to run
* Replace the thunk with its value to avoid recomputation
* Set the pointer to null on the time step after its lifetime.
* Nulling pointers guarantees absence of space leaks… but not the absence of
  null pointer exceptions!

It is possible (but clumsy) to prove the correctness of this implementation.
Once this proof is done, we have statically ruled out space-time leaks and
causality problems, ensuring productivity.

# Does This Make Sense?

From the perspective of lambda-calculus, it does make sense in terms of Linear
Temporal Logic.

So reactive programming is temporal logic via Curry-Howard. Awesome! But why
aren't GUIs implemented this way?

The answer is that such programs **do** something every tick of time, it doesn't
just waits for events.  Programming a text editor this way would consume way too
much resources!

# Let's think about callback APIs

```
widget.onEvent : (Event -> unit) -> unit
  : `box`(Event -> unit) -> unit
  : `not``box`(`not` Event)
  : `eventually`Event
```
Callbacks handlers look like continuation/negation types. This is the classical
encoding of "eventually"!

It's worth noting that this is *not* just the continuation monad. LTL's
eventually modality is more than just the CPS monad. There is an axiom that
characterizes the linearity of time:
```
\diamond A × \diamond B -> \diamond (A × \diamond B + \diamond A × B)
```
Programmers know it as `select`,  which reads as "give me an eventually A and an
eventually B, and I will eventually return an A or a B".


