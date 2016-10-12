---
title: Developing a fast and durable pub/sub message bus in Haskell
author: Will Sewell
abstract: Saturday 24th 1100-1125 AM (CUFP 2016)
---

In this talk Will Sewell described [Pusher](https://pusher.com/)'s expierience with using Haskell for a realtime pub/sub message bus.

Slides: https://drive.google.com/open?id=0ByavZVi4q_BaUXdRa1ZRYWdkbjA

He started by describing the team's thoughts on Haskell after a year of use in an industrial setting:

## Pros

* Types
* Concurrency
* Tooling
* Hiring

## Cons

* Too many ways of solving the same problem
* Error messages
* Tooling is good, but can be fiddly to set up and there is unrealised potential

The remainder of the talk focused on a problem where GHC's GC had unacceptable pause times when the working set was large and long lived. This is generally because it is optimised for throughput over latency. See James Fisher's [blog post](https://blog.pusher.com/latency-working-set-ghc-gc-pick-two/) and [Stack Overflow question](http://stackoverflow.com/questions/36772017/reducing-garbage-collection-pause-time-in-a-haskell-program) for more info. To solve this problem we would need a concurrent ([like Go](https://blog.golang.org/go15gc)) or incremental GC ([like Ocaml](https://realworldocaml.org/v1/en/html/understanding-the-garbage-collector.html)) for the old generation. Ultimately Pusher rewrote the system in Go.

There are future developments that could help:

* The [compacting collection algorithm](https://downloads.haskell.org/~ghc/latest/docs/html/users_guide/runtime_control.html#rts-options-to-control-the-garbage-collector) could be worked on in order to get worst case latencies more in line with Ocaml or Go
* [Compact regions](https://phabricator.haskell.org/D1264) ([paper](http://ezyang.com/papers/ezyang15-cnf.pdf
))could be used so that long lived objects do not need to be traversed during a collection
* An application of [linear types](https://ghc.haskell.org/trac/ghc/wiki/LinearTypes) could be a kind of type safe manual memory management if it is ever worked on

In conclusion Haskell is great, but think twice for realtime systems with a large working set!
