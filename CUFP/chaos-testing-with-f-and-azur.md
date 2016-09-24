---
title: Chaos testing with F# and Azure
author: avsm (Anil Madhavapeddy)
abstract: Saturday 24th 1145-1210 AM (CUFP 2016)
---

Why Chaos engineering? There are lots of ways to test. If youre building
systems that scale, have you tested various things like timeouts that are hard
to comprehensively cover. The Volkswagen emissions scandal was detected because
the results were too uniform, and not enough chaos!  Its super important to
test the interactions in your environment.

Jet.com is a NYC based startup that launched in July 2015 and is an ecommerce
company that was bought for 3.3 billion purchase by Walmart.  Has around 700
microservices and is a heavy user of F# and is not a heavy user of AWS since
they are in competition with Amazon. Also a large variety of technologies like
Python, Node, R, Python etc and not afraid to find the right tool for the job.

> "I have now delivered three business critical applications written in F#.
> I am still waiting for the first bug to come in"
>  - Simon Cousins , UK Power Company

Most loved languages in a recent survey on SO were mostly functional
programming languages.

### What is Chaos Engineering

Chaos engineering is about breaking things, but in a controlled way to see what
will go wrong. "lets try a negative one of something and see what happens".
Especially with a distributed system its important to test all the interactions
so that it will actually work at scale.

Principles of chaos engineering:
* Define "normal" behaviour (e.g. a shopping cart)
* Assume normal will continue in both a control group and an experimental group
* Introduce chaos -- servers that crash, hard drives that malfunction, network connections that are severed, etc.
* Look for differences in behaviour between control and experimental groups.
