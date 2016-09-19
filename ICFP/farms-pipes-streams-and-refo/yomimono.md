---
title: ICFP 2016: Farms, pipes, streams and reforestation: Reasoning about structured parallel processes using types and hylomorphisms
author: yomimono
abstract: Farms, pipes, streams and reforestation: Reasoning about structured parallel processes using types and hylomorphisms
---

* came in slightly late, oh no!
* need to choose best parallel abstractions
* parallel task farms: fixed number of workers, each does `f` in parallel to each (independent) input
* parallel pipeline: compose two operations `f` and `g`, pass the output of `f` to `g`, each can happen in parallel over individual elements in the input stream (iow, piecewise)
* image merge: composition of `mark` and `merge`, and there are loads of alternative parallel implementations even just using farms and pipelines
* with this type system, decorate the function type with an annotation that says how we want to parallelize the program -- (e.g. use a pipeline or use a farm).  the typechecker can then pick a parallel implementation that it can ensure is functionally equivalent.
* we can leave holes in the types too -- the type checker can replace them with structures that minimize the parameter cost model (I don't understand this, what's a parameter cost model?)
* in order to actually do this (minimize the paramter cose I guess?) we need to decide semantic equivalences and then do semantic unifications of structures.  (that sounds hard)
  - the type system uses a structure-equivalence relation, where you say that two programs are "extensionally equivalent" (?), and the relation is derived from a denotational semantics of skeletons (???)  "we define it for a number of skeletons (e.g. task farms, pipelines, feedback loops, parallel divide and conquer) using common recursion schemes (map, iteration, catamorphism, anamorphism)"
* so now we reduced the parallel problem to recursion schemes, for which we have some solutions
* "hylomorphisms" - generalization of a divide and conquer; "there are laws and properties of hylomorphisms that can be used to decide semantic equivalences"
  - "hylomorphism is equivalent to composing a catamorphism and an anamorphism"
  - ex: quicksort hylomorphism
* decision procedure - do normalization then unification; erase the parallelism and then normalize ("reforest") then unify.
* if we want a farm of a parallel pipelines, we leave some holdes... then normalize the left hand side(split the hylomorphism into cat/anamorphisms, and the map into the two maps), normalize the right hand side (add constraints to the map which we can know from... ?), then do a unification, which gives the constraints from which we get t eh final form, which we can then use to get the actual program.
* getting back to this cost function - we want to minimize "the cost model" which it looks like is a proxy for computation time.  Generate a bunch of possible solutions and then see which one is cheapest, pick that one.

* why is this good?  it has types (yay!), clear separation between structure & functionality of program, documetnation of how the program was parllelized, easy to change the parallel structure without modifying the functional behavior (iow you can affect performance without risking affecting correctness), compositionality enables easy defitnition of new structures.  also, this automated discovery of nice parallel structures is pretty neat!  we can automatically rewrite programs to minimize costs which is quite powerful.

future work
* future work: apply this to an FP language
* use program shaping to introduce hylomorphisms into a program that doesn't already have it
* stencil and bulk synchronous parallelism
* more complex equivalences!
* implement backends and run the programs!

questions
* what if the example were *three* things composed rather than two? A: then the unification will give two instantiations for those holes, so we have to disambiguate it.  if you don't specify a cost model you'll get the first one, but if you have a cost model you can decide that way. Q: then when I've got five? A: yes, same thing. Q: my conclusion is that this doesn't generalize well, at least the pattern-matching aspect. A: we can consider using the cost model to direct the way we do this unification.  then we can look for th emost heavy operations first and do the unification in that way.
* have you investigated other recursion schemes beyond hylomorphisms? dynamorphisms? A: that's also something we're interested in. we used hylomorphisms b/c we can use it to get canonical representations of programs, but we're interested in more complex recursion schemes.
* did you try to map [???] A: right now we're focusing on algorithmic skeletons, but we could consider other models; as long as you can describe the functional behavior in this language, we could try that
* can you go into more detail on how your cost models work? A: just sample cost models, we left most of he details out because they didn't help much.  we're now working on combining these with some notion of sized types, then use the sized types for the cost models. Q: you mentioned using the cost models to guide the unification, how would that work? A: what I meant is that... if the cost models are not built in, we can't use them other than as a filter.  but we could provide some idea to the unification of the cost models, then we could use some search that uses the cost models.  but I shouldn't really say much about this, it's just an idea
