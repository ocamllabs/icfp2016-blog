---
title: A functional programmer's guide to homotypy type theory
author: OlivierNicole (Olivier Nicole), yomimono (Mindy Preston)
abstract: Wednesday 21st 0915-1015 AM (ICFP 2016)
---

Two separate notes:

# Olivier Nicole notes

In a world when all functions secretly "do" something…
When we think about CPOs, every function has the property that is preserves the
partial order.

In the world of homotopy type theory, types are spaces containing points and
paths.

A homotopy is a continuous deformation that transforms one path into another.

#### Functions "secretly" act on paths

A function doesn't only maps points to points, it maps paths to paths.

#### Applicative interface

With applicatives, unlike with monads, effects can influence the values but not
the structure of computations.

Every monad is an applicative already.

Adapting code from one interface to another is quite boring and morally, we
shouldn't have to do it more than once! And precisely, there is a bijection
between the old and the new interfaces of Monad.

That's the idea of univalence.

**Path-related types do not have same elements but paths between types induce
bijections.**

Voevodsky's univalence axiom postulates that, conversely: bijections between
elements induce paths.

#### Which types act on paths?

* It works for: product types, sum types, (co)inductives types…
* It doesn't work for: intersection types and intensional type analysis.

#### Datatypes with paths

Example: patches in a version control system are paths [Angiuli, Morehous, L.,
Harper]. `Repos` is a type containing all possible repositories.

Then paths between paths correspond to *laws* we want our patches to comply
with.

Big picture: move from semantics where all functions **are** something to
semantics where all functions **do** something.

# Mindy Preston notes

* something we can do: describe higher homotopy type objects with FP; you can use *that* for mechanized proofs in proof assistants
* homotopy type theory connecting mathematicians and philosophers with the FP community (new perspectives are rad!).  talking about not that, but "what all of this means in programming terms", and what we can learn in programming from this work

* what even is homotopy type theory?
  - don lafontaine, the "IN A WORLD" guy
  - so we're going to be IN A WORLD where all functions are monotone and preserve lease upper bounds... (lambda calculus)
  - move from considering "a world where all functions secretly *are* something" to "a world where all functions secretly *do* something"
    - where "secretly" means "implicit because of the WORLD we're in"
    - you can "get code for free" to get generic programs, and we can add new principles that depend on them
  - types are spaces - each is a space with points and paths; points are programs that have that type.  they can be literally the same point, or they can be joined by a path.
  - many types are discrete (example: `Nat`) and don't have paths
  - paths look like equality.  there's `reflexivity`, `symmetry`, `transitivity`.
  - paths are really *data*, they're not a predicate.  you can have two different paths between the same two points.  they might not literally be the same, and they might not even be connected by a path themselves.
  - a path between paths is a homotopy.
  - all functions act on paths; this is implicit in the fact that it's a function.  What we actually write is someting th atlooks like the code that acts on points.
* voevodsky's univalence axiom.
  - what am univalence?
    - given that we have monads,
    - and applicatives, where "effects influence value but not structure"
    - and that every monad is already an applicative,
    - you can extend the monadic interface to applicatives, and you shouldn't have to do it more than once -- the rules apply to *all* monadic interfaces
    - there's a bijection between the non-extended monadic-only interface, and the extended-applicative interface; we can interchange between them, and they compose to `id`.
    - partially evaluate to modify source code
* how does a mechanism inspired by homotypy type theory help us here?
  - we're in a world where there's a structure of paths between types, so we'll set things up such ahtat a path between types does what we want to do.
  - paths between the same points ("path-related types") do *not* have the same elements, but paths between types induce *bijections* and they're mutually inverse.
  - conversely, bijections induce paths between types; that's the univalence axiom :D
  - and what that does is apply the bijection "it's a beta-reduction"
  - type constructors act on points (and implicitly on paths -- the "arrow type" lets you do this)
  - so getting back to our example, the thing we want to change is monad into applicative-implies-monad.  Because that function acts on paths, our function C applied to the path between monad and applicative-implies-monad... exists.  what does it do?  you can coerce along it.  Looks for holes & applies the given bijection there.
* in a world where all functions act on paths, and paths between types induce bijections, you can allow bijections to induce paths, and therefore lift any bijection by a generic program
  - which types act on paths? doesn't work for intersection types or intensional type analysis
  - this is useful *if* we have a bunch of bijections to grab from; luckily this is the case
  - cubical type theories - bezem, coquand, huber; cohen coquand huber hoertberg; polonsky; altenkirch, kaposi; isaev; brunerie, licata; angiuli, harper, wilson;pitts, orton
    - "if you have three sides of a square, you get a fourth side", and same for all-but-one sides of a cube
* datatypes with paths - what can we do besides think about univalence?
  - example: patches as paths (angiuli, morehouse l., harper from icfp a few years back)
  - you define a domain-specific data type with the operators you need and get generic stuff out of it, because of THE WORLD you're in
  - points are repo contents, paths are patches; paths between paths are equations between patches; laws are squares.
  - higher inductive type example, w/interpreter; we define the actual swap code (for bijection) and a proof about the swap code

wren romano from google, Q: why should we believe univalence? is there useful intuition? A: there are mathematical models [named, but I missed them D:]
derek dreyer from max planck, Q: when moving from monad to monad-implies-applicative, you might lose your efficient implementation, so don't you lose information? A: the round trip will only happen in proofs Q: I missed how you distinguished the  "in proofs" part A: in a hot setting, you could end up doing that ronud trip in a path.  if your paths are only used for verification, it's [??? probably something meaning ok]
?, university of nottingham, Q: is it possible for the coercion itself to implement inefficiency? A: that's not well-explored
jeremy ?, university of oxford, Q: what about changes in representation that aren't bijections? A: universe of types and retractions, directedness, other related models
Q: IN A WORLD where types are this rich, is there a place for place people to think about data as untyped? A: I don't think so? leverage came from knowing that the type; using it as a guide to write code.

