---
title: Extracting from F* to C: a progress report
author: avsm (Anil Madhavapeddy)
abstract: Thursday 22nd 1100-1125 AM (ML 2016)
---

Protzenko is going to talk about [F*](https://www.fstar-lang.org) to C compiltion.

Related work:
* Bedrock was the deep embedding of C into Coq. You can prove functional correctness (and memory safety) using nice DSL.
* Cogent at ICFP 2016 is a DSL with linear types and polymorphism with safety proven via a shallow embedding using Isaebl.
* Idris has a C backend also.

Everest: VERified Secure Transport is a major effort at MSR to build a verified
TLS stack. TLS is broken in two ways: the protocol is broken with various
attacks, and the implementations are broken (e.g. OpenSSL) with memory
unsafety.  They want to not only prove the code right, but also ship it with
the generated code implemented in products such as Firefox/IE.  This is why C
code is so important (for embeddability in existing products).  Performance is
important since cryptography is hand optimised machine integers, and there is a
lot of math that needs to be written using direct machine integers.

## Theory

Pipeline is:
* from F* to extraction/erasure which goes to Low*
* Low* can be that can be simuated to C*, which can be proved to C
* C* is an idealised C

Low* is a first order low level fragment of F*:
* limited subset of C - stack allocated buffers and locally mutable variables
* Code is written against a new library called HyperStack.
* Code has to match pre and post conditions to be considered safe
* Low* is an expression language with semantics by substitution.

C* is much closer to C:
* Statement lanuage
* Semantics with continuation contexts ('telescope')
* Much lower level language than Low*

For Low* to C* there is a refinement step that shows that every compilation
step is valid in the high level program. Every reduction step in C* maps to a
set of valid reduction rules in Low*.  Therefore C* program only does "things"
allowed by the original semantics of Low*.

This is the CompCert style which works if C* is deterministic (yes) and Low* is
safe (yes).

This gives us safety and observational equivalence of traces which is super
important for crypto code due to side channel attacks (when you branch, can
reveal information).  If a Low* program is side channel free then same holds
for C* (very important).  This means tht parametricity can be used to show side
channel resistance (next work in progress).

The memory mode:
* list of stack frames
* tip of the current stack frame tracked
* Each stack frame maps locations to values
* A special parameterised push and pop frame function
* Use a Stack effect to present the layout of the stack and not allocate in any other frame. This is impossible in the C model and so the stack effect can be used to compile C functions.

The tool is called KreMLin which takes type erased F* and ensures it can convert from Low* to C*.

*speaker shows a demo of KreMLin*
