---
title: A functional programmer's guide to homotypy type theory
author: your-uid-here (your-name-here)
abstract: Wednesday 21st 0915-1015 AM (ICFP 2016)
---

# In a world when all functions secretly "do" something…

When we think about CPOs, every function has the property that is preserves the
partial order.

In the world of homotopy type theory, types are spaces containing points and
paths.

A homotopy is a continuous deformation that transforms one path into another.

# Functions "secretly" act on paths

A function doesn't only maps points to points, it maps paths to paths.

# Applicative interface

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

# Which types act on paths?

* It works for: product types, sum types, (co)inductives types…
* It doesn't work for: intersection types and intensional type analysis.

# Datatypes with paths

Example: patches in a version control system are paths [Angiuli, Morehous, L.,
Harper]. `Repos` is a type containing all possible repositories.

Then paths between paths correspond to *laws* we want our patches to comply
with.

Big picture: move from semantics where all functions **are** something to
semantics where all functions **do** something.
