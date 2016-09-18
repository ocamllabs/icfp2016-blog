---
title: TyDe 2016: Choose your own derivative
author: yomimono
abstract: Sunday 18th 0955-1015 AM (TyDe 2016)
---

[paper preprint](http://www.cis.upenn.edu/~jpaykin/papers/psf_choose_2016.pdf)

* introduction and motivation: timers, chooseEither and chooseList, if we want to unify them `choose :: a -> Event ???`
* previously epxlained `chooseList :: [Event a] -> Event a`, but you can't know which channel the winner came from
  instead, how about a list of pairs of identifier, event?  Then we get context back in the return type:
  `chooseList :: [ (id, Event a)] -> Event (id, a)`
* or roll this all up, so `choose` gives prefix and suffix so we can figure out which channel the result came in on:
  `choose :: [Event a ] -> Event ([Event a], a, [Event a])`
* "the derivative of a regular type [with respect to X] is its type of one-holed contexts [with a hole for values of type X]" ([http://strictlypositive.org/diff.pdf](Conor McBride))
  (I definitely don't understand this.)
* we want contexts with a hole for the synchronization points -- the time when the synchronization occurs.  So define the derivative with respect to events, with a hole for the time.  Our result type then is `choose :: a -> Event (derivative of Event with respect to a)`.
* product rule (McBride pushes this further: sum and chain rules)
* [implementation work in progress](https://github.com/antalsz/choose-your-own-derivative) - spawn all events in a, record the winner of the rase along with context, produce an event that waits for the race winner
* future work: the derivative operation with respect to event doesn't depend on the semantics of event (as is clear from the formulation above).  so you might define this derivative with respect to some other thing!  is this `choose` structure useful elsewhere?  Random generators?  Parser combinators?

Questions:

* Q: what are the laws that govern the functors that you can use this with?
  A: for the syntactic derivative operation, "it's sort of like a constructor".  choose needs a functor; it might not have to be a monad depending on the specific semantics.
  Q: "does it have to be a sum of products?"
  A: don't think so.
  Q: "the *type* must be built out of a sum of products" but not the functor.
* someone mentions something about parser combinators but I miss it entirely
* Q: "could you generically define a derivative?" that would be great, let's talk about it
* Q: how convenient is it to use the types that you get out of the derivative operation?
  A: "it's not very convenient to use those types directly"
  Q: any plans to make it easier?
  A: "there's a basic-level pass that collapses 0 times a, 0 plus a, etc ... [can maybe use isomorphisms?] zipper type, convert back and forth"
* Q: transactional?
  A: it doesn't have to be -- what you get back after completion has some events inside of it; you get a pointer for that currently running computation, so if you wait for it it'll continue with the computation that already got stated
