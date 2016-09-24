---
title: OCaml inside: a drop-in replacement for libtls
author: OlivierNicole (Olivier Nicole), gemmag (Gemma Gordon)
abstract: Friday 23rd 1425-1450 PM (OCaml 2016)
---
# Olivier's notes

*The speaker starts by showing an example of playing a video through a channel
encrypted using ocaml-tls*.

## Challenges

* Libraries are mostly written in C, and used by C programs.
* Memory management, language idioms.
* Does switching to another language introduce an important performance loss?

## Introducing the library

It is a C binding to `ocaml-tls`. It is compatible with LibreSSL's `libtls`. It
aims at being safer than `libtls`, OCaml being by essence a safer language than
C.

## Performance

* `libnqsb-tls% is around 70 % as fast as `libtls` in comparable conditions.
* Attempted comparison with pure `ocaml-tls` shows a 10 % decrease overall.

This library can run inside OpenBSD software like `curl`.

# Gemma's notes

## Overview

c binding to ocaml tls designed to be fully compatible with libtls in open bsd

**Challenges in replacing a system library**
e.g. libreSSL

- Libraries are mostly written in C, and used by C programs
- when replacing it with another language, memory management becomes a problem. C is manual, OCaml has GC
- does switching intro a perf loss. C libraries are usually very fast...

**libnqsb-tls**

- a C binding to ocaml-tls
- compatible with libreSSLs libtls
- uses almost no manually written c stubs - uses c types

replicating the libtls interface
complex interface

**Bridging programming styles**

- in libtls, configuration is done through many setters in libtls
- configuration validation

can uncode the scenarios with types. Makes it easier to check the configuration implementation.

## Harmonising memory management
**Probs**

- want to take a lot of ocaml values and put them over to the c side -> problematic for GC
- value can get moved during GC compaction, and program will crash

**Solution**

- ocaml-ctypes can return a pointer to a block registered within the runtime that holds the address to actual value
- if the value is moved, then the address is still valid
- manual management of this block is needed
- BUT can still end up adding a call to malloc by OCaml code - dirty but you get used to it

**Performance**

- library is around 70% as fast as libtls in comparable conditions.
- comparison between pure ocaml-tls to libtls - 10% performance decrease in a naive implementation

lots of possibility for improvements here

**Integration with system services**

- this runs within openbsd's httpd, netcat, curl, ftp
- some cases with unexpected behavioural differences - e.g. capabilities system for openbsd - it is difficult to match the behaviours match

## Q&A

Q: overall bulk perf numbers but no determinism of the latencies - do you have any numbers of the latency distribution. I would like to measure, but we didn't have time. We have numbers of ocaml-tls vs lib-tls. Seeing where the performance is distributed, will be helpful.

Q: Propose to openbsd. This is a package - in debian you can have a variable package so you can choose. In systems that adopt libtls, then it can be tested.

Q: why nqsb? Not quite so broken. From tls implementation.
