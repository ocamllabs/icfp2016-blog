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

Benefits:
- self service as you write your own tests
- design for failure
- learn from the experiment

Is this just Chaos Monkey? They have a bunch of related products (Janitor
Monkey, looks for unused resources). There is an AzMonkey that runs on Azure.
They were all too large scale (take down a cluster) rather than a more
manageable scale to start with (take down an instance). Dont want to destroy
the engineering team with bugs!

Its obviously very very important to not test in production to start with!

The code looks like straightfoward:

```
computer
|> getHostedService
|> Seq.filter ignoreList
|> knuthShuffle
|> Seq.distinctBy (fun a -> a.ServiceName)
|> Seq.map (fun hostedService -> async {
   restartRandomInstance compute hostedService
})
|> Async.ParallelIgnore
```

ignoreList is to get ability to stop random testing for short period of time.
Not encouraged to maintain long term ignore lists but the ability is useful.
The map then restarts one service among the list and runs rest in parallel.

Did this help?  One good example was ElasticSearch restarting. Search noticed that
data wasnt coming back and the pricing team noticed errors. It turns out that ES
was down and had been cascading issues out. This was found because Chaos restarted
it and it took days for devops to get QA back up and running.  If you want to be
prepared then test for failure!

# Q&A

Q: How long before this gets to be standard part of engineering culture.
A: Senior leadership has bought into it, but it will take some time to really embed.

Q: Are Azure services too stable and so chaos engineering less useful?
A: Not quite -- all of the things have bugs!
