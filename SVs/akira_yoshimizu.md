---
title: It's practically useful in such a concrete way!
author: Akira Yoshimizu
---

I'm Akira Yoshimizu, a 3rd year Ph.D. student (under the supervision
by Ichiro Hasuo) at Department of Computer Science, Graduate School of
Information Science and Technology, The University of Tokyo. I was
a student volunteer at ICFP 2016.

I enjoyed the conference; there were lots of exciting talks. In
particular, I was surprised by a paper [Sequent calculus as a compiler
intermediate
language](http://research.microsoft.com/en-us/um/people/simonpj/papers/sequent-core/scfp_ext.pdf)
by Paul Downen, Luke Maurer, Zena M. Ariola, and Simon Peyton Jones,
presented at ICFP main conference.

Briefly speaking, they introduced and implemented a new intermediate
language (called *Sequent Core*) based on **sequent calculus**, unlike
usual such languages that are (essentially) based on natural
deduction. Moreover, the Sequent Core is shown to be as efficient as
the Core language used in the real GHC implementation and better
suited for the treatment of join points. Its actual implementation is
a plug-in consisting of converting Core to Sequent Core, optimizing
the translated Sequent Core codes, and converting back to Core. The
results are accompanied by theorems assuring type preservation of each
way of translation and observational equivalence of round-trip
translation.

I've been working on applying a semantic framework (called Geometry
of Interaction) in linear logic to semantics of programming
languages. As expected, I've seen and done quite a lot of formal
proofs, sometimes in the form of sequent calculus (and sometimes
proof nets). As a matter of fact, I like sequent calculus, and it's
theoretically convenient --- but I've never thought that it's
*practically* useful, in such a concrete way! Listening to the talk
and reading the paper was simply fun for me.
