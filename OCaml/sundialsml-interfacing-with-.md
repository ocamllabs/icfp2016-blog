---
title: Sundials/ML: Interfacing with numerical solvers
author: gemmag (Gemma Gordon)
abstract: Friday 23rd 1400-1425 PM (OCaml 2016)
---
## Intro
OCaml interface to Sundials
Modelling hybrid systems - a controller embedded in a physical environment

Industrial tools: Simulink, Zelus etc

Simulate the whole system, including the physics - need to hook up with a numerical solver

## Sundials library

- suite of 6 numerical solvers from LLNL
ODEs
DAEs
nonlinear equations
- Feature rich, widely used state of the art

Using it from C is problematic - they are interdependent so you get error return values or a segfault

The OCaml comparison is much safer and less prone to errors. Build up an ADT specifying the options that you want. the type system is forcing you to come up with the right combinations that make sense to the solver.

API done in the right OCaml kind of way

- supports documented features
- modest overhead, mostly <70%

pass big arrays into the solver in a wrapped form

Sundials C library using c-structs.
ffi follows the link from the OCaml tuple into the C library and will follow the backlink to the OCaml call (big array). The backlink is GC rooted so will exist together with the big array payload.

can link with an mpi communicator to support different levels of parallelisation.

## Benchmarks

- 56 examples included in sundial
- reimplemented in OCaml compared to C. in most cases, if array bouncechecking, the OCaml implementation runs with no more than 70% (compared to the value of C) and 30% in many cases.

Fairly low overhead overall
Already used in Zelus compiler as a backend with no observable perf problems

## Q&A

Q: 30% overhead is quite a lot for a binding - usually you'd expect 1%. Why is it so high? We have the binding calling throught the ffi in a tight loop.

Q: Did you make the interface by hand? Yes, because we wanted to have tight control.
