---
title: Making reactive programs function
author: avsm (Anil Madhavapeddy)
abstract: Thursday 22nd 0915-1015 AM (ML 2016)
---

[Neelakantan Krishnaswami](http://conf.researchr.org/profile/icfp-2016/neelakantankrishnaswami)
on "Making Reactive Programs Function".

ML imperative: its afunctional language but has pointers, pointers to code and
pointers to code that are dynamically modified.  How can we ever reason about
it and prove properties about it with such power?  This pattern of dynamically
modifying higher order code shows up a lot in GUIs for example.

Verifying GUIs is useful since applications are easy to get wrong. Adobe did a
study of their projects to find out issues in their codebase. For Photoshop and
similar, a third of their code is dedicated to UI handling and also a
_majority_ of their bugs.  Clicking is harder to get write than graphics
processing implemented in opptimal C++.

The sort of bug they have is interesting; a file dialog box, where JPEG and
PNG can be selected but only one should have a quality slider.  When one is
selected (e.g. PNG) the slider should disappear and not just hang around.

Another example is how to do secure web interaction like email. In order to
trust this computer, you have to understand how the browsers let the Internet
draw on your screen and distinguishing between what is real and not is very
hard.

What makes GUI programs hard is the event loop with all sorts of callbacks from
basic stuff like clicks and keys but also more modern sensors.

```
while (true) {
  let event = getEvent()
  let callbacks = t[event]
  for (f of callbacks) {
    f ()
  }
}
```

Programmers install callbacks in a table and on each event the loop find
callbacks in the table.  This was invented the year the speaker was born so
much have something going for it, but from a formal reasoning perspectives its
insanely hard -- higher order, mutable, functional since code is being
registered and modified.  Any one of these things would be a PhD to reason in,
but working programmers are expected to get this right without any such
assistance!

Hudak et all designed [Functional Reactive
Programming](https://en.wikipedia.org/wiki/Functional_reactive_programming) to
get get around this (Elliott andd Hudak, ICFP 97) by viewing dynamically
varying state as a _stream_. Interactive programming is a stream transducer
that takes streams of inputs to outputs. They are nice because they can be
defined recursively and "look and feel" like a normal functional program.  With
FRP, we have all the
primitives of a normal functional program.

**Trouble in paradise: Causality variations**:
However when you try to use FRP with the stream transducer program, it works
great when it works, but bugs are really hard to find.  For example, causality
is difficult: example given of a stock trading program where tomorrow's price
is used instead of today.  Mathematically, the stream transducer is well
defined, but its bad from the perspective of interaction.  It is trying to use
information from the future in the present.

As a type theorist, the obvious thing to do is to extend the constraints to
include causality in the constraint.  What if we have types for dataflow that
"bullet A" denotes the type of values that are available tomorrow.  An "int"
available now would be "next int" that will be available later and not
accessible straight away.  In this model, taking the tail of a list would give
you a "next int" instead of an "int".

**Trouble in paradise 2: space leaks**:
A leaky program is easy to make in two programs which are syntactically exactly
the same except for their types.  One leaks and one doesnt, which is very
confusing to the working programmers.  Once you add time to a language, values
have intensional content.

A value may be constant over time (i.e. use fixed memory) or change over time
(i.e. use up increasing memory over time).  We need a distinction in the type
system for things that change over time vs constant factors.  The constraint
will be to prevent the programmer from using facts in the present which would
use up our RAM if they had to be tracked for the future.  So lets add some
new types for the "type of Stable A" _vs_ "always A".

We can define a fine program that defines a `const` function which returns a
stable A, and forbid it being called.

Audience Q (Ralf): If you wrote the old leaky program, how would it get
rejected?  A: If you get a boxed stream of natural numbers it would pass the
typechecker, but there would be no inhabitants and so it wouldnt be possible to
call the function without help.

How to implement this?  Idea: stable A are pointers to code:
* For the thunk on the tick it is scheduled to run.
* Replace the thunk with its value to avoid reconmputtion
* Set the pointer to nul on the timestep after its lifetime.
* Nulling pointers guarantees the absence of space leaks.

Q: can we set this up for the GC to collect when it goes out of scope?
A: yes we can! but there are no guarantees that there are no null pointer exceptions :)

The language has higher order funcions and the implementation has higher order
state, so we need lots of advaned semantic technicals from higher order
imperative/concurrent programs -- but only once, for the implementation of the
language and not for every single program.  It is possible to prove that this
will not happen by using some of the modern modern techniques of reasoning over
higher order logic.  Proof uses nominal step indexed Kripke logical relations
(Andrew Pitts, Derek Dreyer et al have been developing these over the last
decade).

Do these make any sense to the working programmer? *shows complex typing rules
on one slide, to general laughter*.  The types include LTL's next-step modality
for stable a and next-A is LTL's always modality, which have good Curry-Howard
natural deducation for LTL (specifically, the model _u_-calculus).

In the case of (e.g.) emacs (the editor for middle ages computer scientists), we want
it to do not do something on every timestep. For GUI apps, we want them to
sleep and not be busy-looping. However for games (immediate rendering), the LTL
interpretation works since they are running at high speed.  For programs that
are event driven though, we need a different interpretation to the LTL model.

Callback APIs can be made to work in this LTL model by using "not box, not
event" which is the classic LTL "eventually".

**Continuation Monad:** This all looks like callbacks in CPS form though? Is this just the continuation
monad though, which JavaScript people already exploit via `Promise.resolve` and
`Promise.then`.  The LTL eventual modality is more than just the CPS monad though.

    *a x *b -> * ( a x *b  + *a x b )

This is what the familiar `select` function does -- given an *eventually A* and
a *eventually B*, give me one of them and lose the other one.  Implementing
`sync` between two eventual values requires higher order state and allocating
an empty reference cell.

**The Correctness story?**

Proof theoretically we have normalisation results for LTL, but the axioms
require higher order state to implement. The implementations are "obviously
correct" but we cant prove it!  Step indexed logical relations cant prove
liveness, but we need new techniques to formally reason about it.

### Summary

This is exciting because although ML is an old language from the 70s, there
are still important lessons to be learnt from it in the application to all these
exciting new techniques.
Plain old sequential ML has lots of mysteries to it that we need to understand
that we can use to scale to prove the liveness of concurrent programs. 

### Questions

*Q:* The model typing seems to be similar to the French school of synchronous
dataflow paradigm.
*A:* Lucid Esterel etc are a family of dataflow languages that compile to a
state machine given a set of recursive equations. The work here can be understood
as a higher-order version of synchronous dataflow. We lose the ability to compile
to non-allocating state machines, but that is lost with higher order functions.
However we gain the ability to do dynamic dataflow graphs which is important for
GUIs.

*Q:* Yaron Minsky, to address why dont we use it more?  FRP approaches it wrong
because the problems arent about time but rather about consistency. In the real
world, you keep your state a a pure type, your view as a pure function which
renders it, and normal functions to modify the state.  What is compelling about
the time oriented view _vs_ a simpler optimisation view?

*A:* React/Elm view an immutable set of GUI state and use clever diffs to model
it.  We represent the state explicitly and then render it. At a fundamental
level a stream is a representation of a state machine, and it is important to
understand how to compose these.

*Q:* Do we really want termination?
*A:* Easy answer: I do! Realistic answer: want to rule out deadlocks and livelocks
and the difficult part of concurrent programming.  If we want ordinary recursion
in our language, we probably want to look at termination calculi to avoid
sliding hard problems under the carpet.

*Q:* Can we ensure all the event handlers terminate to ensure system responsiveness?
*A:* Yes except for underlying runtime. Howevert this doesnt guarantee responsiveness
since this is the ordinary lambda calculus and you can have towers of exponentials.
The more basic problem of termination still exists before this is solved.

