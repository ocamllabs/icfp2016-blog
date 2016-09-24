---
title: Keynote (Yaron Minsky)
author: avsm (Anil Madhavapeddy), gemmag (Gemma Gordon)
abstract: Saturday 24th 0920-1015 AM (CUFP 2016)
---

# Anil Madhavapeddy notes

Opened with discussion about types and static vs dynamic.  But FP still not
popular. Go to a top school and its something they have heard of, but still
something that still isnt part of the fabric of the computing world.  Something
problematic about the view that you have to sneak the technology in.

Something worth separating is influence vs popularity.  Many widespread ideas
have started in FP and gone mainstream (Lisp had GC first). The other form of
influence is idioms -- ideas about how to program.  For example, the value of
immutable datastructures hhave shown up in many places such as React.js.

Where FP ideas are used, its often lipstick on a pig, where FP is used to paper
over poor infrastructure.  These are often huge industrial scale efforts that
represent amazing projects, for example Facebook pouring so much work into PHP.

**FP is a perfectly good general purpose tool** and shouldnt be viewed as a
narrow niche. Jane Street is a good example of a place that does it, or Erlang
at Whatsapp. Computer Sci is in many ways a mathematical design process (like
architecture) more than a scientific discipline. The evidence isnt in yet about
whether FP or imperative is better or worse.

**You cant value what you dont understand**, which is a problem for FP.  For
example, Yaron wasnt excited when GADTs were added to OCaml. "Im a systems
programmer, I dont care about types!". But it turns out that they are really
good for optimisation, and also they made a bunch of complex encodings
involving existential types much simpler.  The addition of the feature to the
language was worthwhile despite being initially daunting.

**The right tool for the organisation.** you want to maximise various forms of
sharing and the power of the individual developer. Having a small number of
tools and developing shared standards so people are transportable between areas
is enormously freeing for managing and evolving the organisation. Companies
that standardise in their language choices (e.g. Google with C/C++/Python/Go)
do have an advantage (despite not agreeing with Google's particular choices).
In a company, the individual speed with which you can do the job matters, but
you also need other people as you scale up. This leads to the cost of
collaboration increasing as you communicate more.

**You broke it, you bought it.** When JS was first hiring, they pulled in lots
of early staff who were really good functional programmers.  Later they started
hiring from schools fresh graduates and also people who arent traditionally
programmers. The base grew from dedicated programmers to people who are
learning FP for the first time. The hard bit about working on a minority
language is that you have to foster community. JS has spent a lot of time
funding the building of infrastructure that they do not use directly.  For
example, OPAM is a package manager funded by Jane Street that built a community
around OCaml but isnt directly used at JS. But the community is enormously
important as a source of growth and ideas.  The result has helped them hire as
well.

For organisations in this position, Yaron recommends that you do not take a
narrow view of what you need. Its valuable to foster them more generally and
then benefit from having a seat at the table for them to listen to your
concerns over the longer term.

**Academia isnt academic**: There is a back and forth between industry and
academia for various things (e.g. Incremental) and its important that this
be bidirectional. Learn from academia but also tell them when your realworld
problems dont fit their worldview.

**Teach your children well**: large number of schools teaching functional
programming as a core part of their curriculum. But there's still something
tenuous about the state of affairs, since functional programming still isnt
recognised as a really important part. The people who care most about FP are
the ones who study it, so they tend to teach it more. But if you as a non
academic care about hiring and industry option, then can help by building
community.  For example, resources like Stack Overflow and other shared
knowledge bases take a lot of people to contribute in (try OCaml vs Java in SO
to find the scale difference).  Jane Street has an OCaml bootcamp where they
have lots of tooling to help beginners. Go is a fairly uninspiring language
with amazing tooling to make the programmer productive. Its easy from a POV
that values the language to underestimate the important of tools.

# Gemma Gordon notes


