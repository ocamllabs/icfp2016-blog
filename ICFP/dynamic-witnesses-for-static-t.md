---
title: Dynamic witnesses for static type errors (or ill-typed programs usually go wrong)
author: OlivierNicole (Olivier Nicole), yomimono (Mindy Preston)
abstract: Tuesday 20th 1330-1355 PM (ICFP 2016)
---

Two sets of notes for this talk.

# Olivier Nicoles notes

### Witness visualization

When entering the ill-typed `sumList` function in the visualizer, it shows that
`sumList [0]` implies the ill-typed call `0 + []`.

### Evaluating witnesses

Benchmark: over 4,500 ill-typed programs, witnesses could be found in less than
10 s.

Are witnesses simple? 57 % of traces have less than 5 jumps.

Are witnesses helpful? User study with undergrads at UVA (n = 60): grades were
10 to 30 % better when they used the compressed jump trees.

# Mindy Prestons notes

* find execution paths that trigger a problem rather than putting the blame on static type location info

* motivating example: something that will generate a pattern match failure
* generate lenient inputs -- we want to progress "as far as possible" (this is intuitively appealing; it feels close to "the problem" that presumably we have)
* "jump compress trace" - simplify the graph on the way to the witness; can we do that generally? paper says yes!  if we find a witness, then for all inhabited input types, there exist values that will make the computation fail.  then generalize to many inputs (currying doesn't just get this, because type errors can be hidden by lambdas - fold_left with an insufficient pattern match example)
* ooh, a demo!  "nanomaly", they've used this at UCSD for instruction.  this seems *super useful* for people who are coming from dynamic languages
* a number of exmaples where the error message given by the type checker just shows the inference results, which could give more useful information when things disagree.  generally we get error messages for the *non-first* disagreeing type defintion in stuff like matches and branches, but it's also possible that the *first* is the erroneous definition -- do any of the "better-errors" type branches for OCaml do better?  Elm's errors are (now) great for this; now that I remember, don't they do something like this?
* experimental results: asking students to explain and fix type errors; they do better when witness information is included (...one would hope that students do better with more information)

Q: you might find other errors like head of an empty list or division by zero; do you include those in output to the user? A: yes, we tell them Q: there are some things that are type errors that don't lead to a runtime error unless you put them into a context. have you thought about providing a context? A: that would provide for a nicer visualization than what we currently do (loop over the input multiple times)

