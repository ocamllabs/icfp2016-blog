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

Hudak et all designed Functional Reactive Programming to get get around this
(Elliott andd Hudak, ICFP 97) by viewing dynamically varying state as a
_stream_. Interactive programming is a stream transducer that takes streams of
inputs to outputs. They are nice because they can be defined recursively and
"look and feel" like a normal functional program.  With FRP, we have all the
primitives of a normal functional program.

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

