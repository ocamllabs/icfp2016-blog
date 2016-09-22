---
title: Higher-order ghost state
author: yomimono (Mindy Preston)
abstract: Tuesday 20th 1420-1445 PM (ICFP 2016)
---

* nice framing of rust as balancing safety with *control*, rather than speed as I often see this tradeoff of higher-level v lower-level languages formulated
* rustbelt: prove safety of language and its standard library
* what do we need for this? higher-order concurrent separation logic.  we have a lot of them and they're complicated.  previous (Iris at POPL '15) they tried to make this simpler with two mechanisms: invariants, user-defined "ghost state".
* "ghost state" - stuff like capabilities, trace information, auxiliary program variables... for user-defined ghost state, mix and match them for verification.  there's common structure of this state -- "partial commutative monoid", a set M with an associative & commutative composition operation.
* use these simpler things as foundations for deriving more complex stuff, but we can't quite get at synchronization primitives that way
* ghost state about the logic wasn't supported by iris 1.0 -- circular dependency with the ghost-state itself.  that's the "higher-order" here.
* why do you want higher-order ghost state anyway? probably for synchronization primitives... yeah, example given of a barrier.  formulate this in terms of capabilities to send/receive the thing you want to have cross the barrier. (spec for this -- mike dodds et al 2011, flawed originally, fixed using named propositions)
* in iris, we want to talk about named propositions as ghost state.  and it's ghost state about logic.  so we want it.
* step-indexing, 2001 appel and mcAllester, used to solve circularities in models of higher-order state
* give PCMs a step-indexing structure to yield someting called a CMRA; let users define a functor yielding a CMRA.  any PCM can be lifted to CMRA which means the user who doesn't care about non-higher-order ghost state (first-order ghost state) doesn't have to worry about this; step-indexing doesn't leak.

