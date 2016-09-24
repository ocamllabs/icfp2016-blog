---
title: Improving the OCaml webstack: motivations and progress
author: gemmag (Gemma Gordon)
abstract: Friday 23rd 1730-1755 PM (OCaml 2016)
---

## Motivation

- IT backend services written in ocaml
- background in production web services in ruby, php and python
- chose cohttp as the server library to build upon
- async for monadic concurrency after false start with lwt

## New features built

Pieces still missing in community - had to build them and glue them together - diverted effort from R&D

- URI dispatch library: break up server logic into separate URI handlers. Cohttp had no built in support so built it.
- session management: cookies and generating random user ID to set as cookie value. Provide pluggable backends for storing the state associated with IDs, and essential for services with user accounts
- http framework/webmachine: an API for writing REST services. A port of the erlang project to OCaml, model a request handler as a state machine, user specifies behaviour of individual decision points - a great API for creating REST services that conform to the http specification. Get content negotiation and caching logic for free. Uses cohttp.
- cohttp scalability - under heavy load they don't scale well. Inconsistency with error handling across implementations, conduit is a pain (separate library that handles the exception of the cohttp library) necessary for client-side code, but unnecessary for server-side applications as ssl termination is done by a proxy. Async had poor server-side performance. May be linked to functor use in cohttp which lead to unusual performance artifacts. lwt and async are fundamentally different in how they behave - under heavy load (10,000 concurrent connections) leads to high latency - benchmarks are way off comparisons with haskell etc. So decided to remove functors - readability is hindered by their presence SO wants to implement parsing/serialisation as pure libraries that surface data types - similar to algebraic effects
  - angstrom: parser combinator library based on haskell attoparsec. Supports incremental input so you can make progress even if input is not complete. Not tied to a particular monadic concurrency library and it supports unix blocking behaviours
  - farady: serialisation library that buffers small writes and batches larger buffers. Based on Jane Street's writer module
  - http/af: combination of angstrom and farady as a rewrite of cohttp. Main package consists of pure code that implements aspects of http specification. unreleased but on its way.

**Results of http/af and status**
Once the server is under heavy load it can't accept requests enough - accepted by the kernel but cannot be accessed. Opportunity based - will take on more work when opportunity there. Throughput excellent but performance needs improving

Nearly there!
http/af combined with dispatch, session, webmachine begin to approach the experience that most backend devs are used to.
BUT not a good story for code reuse through middleware stacks.
Webmachine is an expert mode interface and not recommended for beginners or quick and dirty jobs.
  - opium by rudi released on github provides a simpler interface, also RIP by Dario - more similar to Ruby's sinatra and python's flask

status update of stack - would like more involvement

## Q&A

Q: tree monads are your solution to functors? Yes

Q: async and lwt are different in terms of bind behaviours - true but could have implemented an lwt-like bind and plugged it into the functor. Yes that's fair, but dis-interleaving the parsing and IO has benefits.

Q: Perf flaw - a copy interface and lowest common denominator in them both. but a free monad solution is an interesting experiment

Q: Where is this documentated? I don't host docs but the mli files have a lot of information
