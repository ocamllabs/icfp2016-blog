---
title: A clear explanation of programming aspects of Homotopy Type Theory
author: Mirai Ikebuchi
---

My name is Mirai Ikebuchi, a student volunteer for ICFP 2016. I am
a master’s student in Nagoya University supervised by Professor
Jacques Garrigue. I am currently working on formalizing big data and
machine learning code on Coq with Professor Adam Chlipala in MIT
CSAIL.

One of the most interesting talk at ICFP for me was Dan Licata’s “A
Functional Programmer’s Guide to Homotopy Type Theory”. The speaker
gave us a clear explanation of programming aspects of Homotopy
Type Theory (HoTT). Roughly speaking, HoTT is a type theory with
a wide notion of equality, called path. An example of path-related
types is a correspondence between two notions of applicative functors,
one assuming that the type is also a monad (with some coherence laws)
and the other not. From this path, one can obtain a side for free from
the other side, in a way like generic programming.