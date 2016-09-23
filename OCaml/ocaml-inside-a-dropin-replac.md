---
title: OCaml inside: a drop-in replacement for libtls
author: your-uid-here (your-name-here)
abstract: Friday 23rd 1425-1450 PM (OCaml 2016)
---

*The speaker starts by showing an example of playing a video through a channel
encrypted using ocaml-tls*.

# Challenges

* Libraries are mostly written in C, and used by C programs.
* Memory management, language idioms.
* Does switching to another language introduce an important performance loss?

# Introducing the library

It is a C binding to `ocaml-tls`. It is compatible with LibreSSL's `libtls`. It
aims at being safer than `libtls`, OCaml being by essence a safer language than
C.

# Performance

* `libnqsb-tls% is around 70 % as fast as `libtls` in comparable conditions.
* Attempted comparison with pure `ocaml-tls` shows a 10 % decrease overall.

This library can run inside OpenBSD software like `curl`.
