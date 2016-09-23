---
title: ICFP 2016: An abstract memory functor for verified C static analyzers
author: jdjakub (Joel Jakubovic)
abstract: An abstract memory functor for verified C static analyzers
---

Targets crit emb softw, eg convince auths that softw running as expected as spec'd. More more complex.

Industry, common practice is manual verification eg code review. Does not scale. Some using auto tools to find bugs.

Problem is that may miss bugs. Use sound-by-stroit' autotools.

<software> used by Airbus.

How do trust verifier?

use formal verfrs using proof asst. How odyou verify verifier? Use both in same language eg Coq

Methodlgy:
prgrm static anlysr in coq. give frmal sems.

Crit C code in crit systme on aeropln. The Verasco Experiment.

Verasco - PL. Reuse parts of CompCert. CompCert subset of ISO 99 C. Uses nontrivial eg rational domains. Modular. Prove absence of undefd behvr. compiler 1/10th of gcc.

Abstrt intrprtr, state abstr, numerical abstr.

Mem abstr naive. Define new mem abstr domain, parametrised, functor. Handles lowlevel eg ptr arith, arrs, structs, unions, casts.

stick to hl ifaces.

prove mem accesses properly aligned. algnment constraints. could not di this ver in UNESCO.

Abstract cell - unit of storage. Distguish btw regs (vals) and chunks (part of a var)

Translate exprs to dom wo mem ld or ptrs.

Elim floats. Abstract mem functor. Something points to a domain.

Access info stored in both doms. Abstract memory functor is abstract.

Block and addrs in concrete mem, in ConCert.
