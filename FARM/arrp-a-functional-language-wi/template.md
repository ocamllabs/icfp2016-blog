---
title: FARM 2016: Arrp: A functional language with multi-dimensional signals and recurrence equations
author: jdjakub (Joel Jakubovic)
abstract: Arrp: A functional language with multi-dimensional signals and recurrence equations
---

Arrp strives to raise bar on code readability. *Compose* smaller sig processes into larger ones without too much overhead.

Static resources, no dynamic mem alloc, zero overhead so high perf realtime.

Signal = multidimensional array with one infinite (time) dim. Semantics inspired by MATLAB, Octave, Numpy.

Easy translation from maths to program via familiar index notation.

`sine_wave(f) = [t -> sin(f*t*2*pi)`
`d(x) = [n -> x[n+1] - x[n]]`
`downsample(k,x) = [t -> x[k*t]]`

Use recursive names, plus recursion using `this` keyword

`a = [5,~: i,t -> sin((i+1)/sr*t*2*pi)]` (tilde ~ is infinite dimension, 5 is 5 dimension etc)

Array currying: multidimensional = curried! (array of arrays...) so also partially index (apply) array

Bounds inference. Look at how index is used, infer bounds.

`delay(v,a) = [0 -> v; t -> a[t-1]]`

### Polyhedral scheduling
Programs are sets of imperative statements manipulating arrays. Functional recursion not yet supported because cannot yet guarantee termination.

Represents all as members of big polyhedral space, apply linear optimization.

Skews schedule, all iterations depending on same value are executed consecutively. Then figure out which things can be parallelized.

Performed much better than C++ in some areas such as speed in Synth and AC (music terminology...). Many many less lines of code too although there seemed to be slightly worse buffer performance,

Future work: ADTs, recursive functions, FFI. Multi-threading, GPU code, compare perf to Faust, Kronos, StreamIt. And, try applying the principles to other langs.

Q: Eg if this now depends on the value of that 7 steps ago? Is there a bound, or could any amount of history potentially be required??
A: Polyhedral scheduling will schedule such that there will always be a constant distance between the cases.
