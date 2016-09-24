---
title: Guix: Scheme as a uniform OS admin and deployment interface
author: gemmag (Gemma Gordon)
abstract: Saturday 24th 1545-1610 PM (CUFP 2016)
---
## Overview

**Guix:**
A functional package manager and a distribution of rules in Unix. GuixSD - free software project, part of GNU project. About building an API and tools that allow you to build software using a purely functional paradigm. System distribution built around Guix. A complete GNU linux distribution.

**Scheme:**
Using Scheme in the context of distribution and OS - uniform OS admin and deployment interface. Scheme is an FP of the Lisp family - purely declarative. OS form that describes the features and configuration points of the system. Once you have a config file (in Scheme) can feed file to Guix system command - can create a qmu virtual machine from there and instantiate on the bare metal. Scheme is an extensible programming language with macros.

**Guile:**
A Scheme implementation that they are using. Provides a recommendation of env variables that you should set.
DEMO: on terminal as example - as an unprivileged user. In a single transaction - he then installed Python as a package. In order to rollback to the previous state - you can check the generations of the software packages - can simply rollback to previous generation. A nice safety net for the user - can transactionally upgrade packages, and can easily rollback.

## Motivations
Keynote on Monday about neural networks and TensorFlow and one of the questions was is there a package manager for neural networks. You want to be able to share software between your networks - there isn't one for neural networks but there are plenty of package managers available: opam, cabal etc. Each language has its own pm - enables everyone to use all of the libraries in their favourite language.

**Problems:**

- It's tricky to build these - when building a machine you are going to have to interact with many different package managers, so how do you reproduce the state of the system that chooses all of the package managers? They typically rely on libraries they assume are available in the ecosystem - e.g. C libraries in OCaml. Between systems you might get different results, as different compilers might not be able to compiler your software
- It's difficult to reason about the state of the system - need to have 2 systems in the same state, but tools work by modifying the state of your machine, so you can't be sure you are getting that matched state on every machine you have.

## Solutions
Functional package management - Nix package manager

1) build process = pure function
2) built software = persistent graph of immutable values

**How is this achieved?**
Need to declare all packages needed as input
Build it and get a hash of all the dependencies eg. build scripts, C libraries
Same paradigm that nix uses.

External DSLs eg. nix language, there's no package abstraction in the language

- can be difficult to identify the packages
- convert the distribution into xml then parse it into your implementation which is annoying

nix mixes bash snippets inside its build recipes which isn't great

Guix approach is to use Scheme all the way down
1) Define global variable, give it as a value a package record
2) emacs IDE (or other) can recognise elements and any dependencies

Works at the OS declaration level by manipulating normal Scheme values.

**Results**
Works well in practice
Embedding DSLs can be a mixed bag - but it has been fruitful for Guix

- emacs and web interface
- guix refresh autoupdater
- guix graph
- guix system services

Have a Scheme api to declare packages and operating systems

**Beyond the current state**
Initial RAM disk
Give Scheme expression to API - uses code staging to embed all the dependencies to run when the system is booted
Having different pieces written in Scheme allows you to generate several layers of Scheme code

**Summary**

- distro and tools as scheme library
- hackability through uniformity
- code staging techniques to glue it together

## Q&A

Q: do you have some facilities to migrate nix install to guix install? Not really. Under the hood guix and nix use the same derivation, so can use same store for both.

Q: What do you think a statically typed system would bring or remove? A problem would be that they rely on dynamic composition - a person's own set of package recipes that can be put in guix package path and added to main distribution - if using statically typed system we'd need to add additional compilation phases. But static typed systems can be fruitful in other ways - enforce certain rules in the package system, and for code staging by making sure you provide correctly typed expressions at staging

Q: I'm a maintainer of opam is network virtualisation - if you want reproducible builds with distributed systems, network dependencies need to be reproduced too - are you interested in virutalising networking? The build env doesn't have network access at all so need to define elements in recipe before hand. If a remote server disappears (for example) and you can't retrieve the file that could be a problem, but we always detect it so our system works quite well atm.

Q: When a new version comes out you have to update the version number etc, but the rest is the same - have you thought about extracting that out with a per package library - a default definition of how to install, and then the version of it separately to enable less editing of the package descriptions. separate version to hash mapping. Have thought about it, but if only one version of a package its not a big deal so don't need to copy definition several times. You can inherit from this record - so you can choose which fields you copy, and you can write a function to return the origin form and you can have several instances of the package record.
