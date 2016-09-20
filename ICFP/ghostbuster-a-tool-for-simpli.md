---
title: Ghostbuster: A tool for simplifying and converting GADTs
author: your-uid-here (your-name-here)
abstract: Wednesday 21st 1035-1100 AM (ICFP 2016)
---

This talk is about Iris, a logic we want to apply to verify the safety of Rust.
Its key contribution is to show how to extend Iris with higher-order ghost
state (see below).

This work is part of the RustBelt project, which aims to prove the safety of the
language and its associated library.

Iris (POPL 2015) is built on 2 mechanisms: invariants and user-defined ghost
state.

Ghost state has a common structure: PCM or partial commutative monoid, i.e. a
set M with an associative, commutative composition operation. So ghost state is
any partial commutative monoid.

With Iris, we can derive the more complex reasoning principles from the
fundamental logic. BUT for specifying some concurrency logic, these fundations
aren't enough!

Iris 1.0 could not handle higher-order ghost state. The contributions of this
work is to show that HOGS is useful and show how to extend Iris with it.

# Named propositions

We give fresh names to propositions. These propositions do not have to hold!

Giving a fresh name allocates a new slot in a "table". We then seek agreement
about that row of the table.

# Conclusion

* Other examples of HOGS can be found in the paper
* We showed how to simplify the model with CMRAs
* We have a Coq formalization

# Ongoing work

* Encode invariants using HOGS
* Applying named propositions in the safety proof of Rust
