---
title: We can reason about cost and semantic equivalences between the different parallel structures
author: Akio Minakawa
---

## Introducing Myself

My name is Akio Minakawa. My affiliation is Tokyo University of Science in Japan.
I'm majoring in Computer Science, researching OS for single board computer like
Raspberry Pi and a student volunteer for ICFP 2016.

## My Favorite Presentation

> Farms, Pipes, Streams and Reforestation:
> Reasoning about Structured Parallel
> Processes using Types and Hylomorphisms
>
> David Castro, Kevin Hammond, Susmit Sarkar

I like this presentation that was presented on ICFP first day.

### Short Description/Summary

If we choose a right combination of algorithmic skeletons, it yields good
parallelism on some specific parallel architecure. However, it is difficult task.

In order to choose the right combination, it is necessary to simultaneously reason
both about the costs of each parallel structure and about the semantic
equivalences between them.

As the solution, he introduces type-based mechanism to enable reasoning about the
properties. He exploits properties of a general recursion pattern, hylomorphisms,
and give a denotational semantics for structured parallel processes in terms of
these hylomorphisms.

By using this approach, we can determine formally whether it is possible to
introduce a desired parallel structure into a program without altering its
functional behaviour, and also to choose a version of that parallel structure
that minimises some given cost model.

### The Reason I Like It

This presentation indicates that we can reason about cost and semantic equivalences
between the different parallel structures without altering its functional behaviour by using
a new type system that annotates its hyle.

If we can reason about costs, we may be able to estimate the worst time that the
process takes from the beginning to the end in the parall sections of the code.

In the embedded device with RTOS (Real Time Operating System), we need to estimate
the worst time that a process takes from the beginning to the end to gurantee that
the process finishes by the determined time. However, if the process use parallelism,
it is difficult to estimate the time. For this reason, we need to choose AMP
(Asymmetric Multi-Processing) and bind each process to specific CPU.

However, as I said above, if we can estimate the time in parallelism, we may be
able to schedule task across multiple CPUs on AMP more easily and safety.

I got the possibility for AMP with parallelism by this presentation. So, I like
this.
