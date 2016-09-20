---
title: Automatically disproving fair termination of higher-order functional programs
author: OlivierNicole (Olivier Nicole)
abstract: Tuesday 20th 1355-1420 PM (ICFP 2016)
---

Plain termination = Every execution eventually terminates.

Fair termination = every fair execution terminates.

An execution is fair iff when event A occurs an infinite number of times, so
does event B.

We are interested in fair termination because it allows (for example) to
incorporate randomness in termination verification.

Disproving fair termination means proving existence of infinite fair executions.

This is done using a tree representation of the execution with two types of
nodes: exist-nodes and forall-nodes.

The tree is then checked by an automaton.

