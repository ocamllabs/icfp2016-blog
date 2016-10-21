---
title: Newer languages seem to be getting the idea
author: Joel Jakubovic
---

I'm Joel Jakubovic, a third-year undergraduate at the University of
Cambridge studying Computer Science, with OCaml Labs over the summer
vacation. I was a student volunteer at ICFP 2016.

I would like to revisit the talk on WebAssembly
([slides](http://www.mlworkshop.org/2016-1.pdf),
[video](https://www.youtube.com/watch?v=OH9NYzH3-74&index=3&list=PLnqUlCo055hX_BCFl3kLW1bB9Mp4wZACc),
[talk
notes](http://icfp2016.mirage.io/ML/webassembly-high-speed-at-low.md)),
the upcoming bytecode format designed to replace JavaScript as
a common deployment platform. It's not particularly functional -- what
the talk was actually about was the fact that the speakers' reference
implementation (by which the semantics are specified, at least at
first!) is written in OCaml. There was much discussion of the unique
feel that using such a language brings to development / engineering
tasks like this one.

It was nice to hear that FP and OCaml-specific ideas helped get it up
and running in just 3 days. "All the usual benefits of FP applied",
referring to ease of reasoning about pure or mostly-pure code, and
static typing catching silly bugs. OCaml stood out in the ease of
using low-level data types, such as `int32` and `int64`, or `bigarray`
(but no `float32`, strangely), even despite the lamented lack of
unsigned arithmetic support. Oh well.

One thing that really resonated with me was the speaker's exasperation
at the lack of widespread adoption of ubiquitous features of FP in
popular languages. "How can people still be surviving without
algebraic data types and pattern matching??" Indeed, I thought. While
newer languages seem to be getting the idea, it seems like many of the
traditional workhorses are stuck without them, and are slow to
adopt...

The talk also touched on the issue of integrating OCaml, and more
generally FP, into existing environments and developer mindsets. Most
people working on WebAssembly are compiler hackers, with an enthusiasm
more for C++ tricks and rather less for unfamiliar and arcane-sounding
concepts like Functors - apparently they are a barrier to entry for
many. To me, it all emphasises the continued need for people to not be
scared of FP, and this will happen naturally as its adoption increases
and people get more familiar with these concepts.

On the topic of adoption, the talk criticised some serious barriers
for people wanting to try OCaml. For example, the fact that, upon
lexical errors, the parser simply outputs "syntax error" with little
or no context. I have had to deal with this sometimes and I haven't
seen it like this in any other languages. Another thing that I have
personal experience with is support for those like myself that, for
whatever reason, ended up using Windows. The current ecosystem doesn't
cater for Windows very well and I had a lot of trouble trying to set
it up. But it is being worked on, so hopefully it will improve in
future.