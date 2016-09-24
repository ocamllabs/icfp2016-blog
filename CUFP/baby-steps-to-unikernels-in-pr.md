---
title: Baby steps to unikernels in production
author: avsm (Anil Madhavapeddy)
abstract: Saturday 24th 1640-1705 PM (CUFP 2016)
---

[Sean Grove](https://twitter.com/sgrove) started by explaining unikernels, and in particular how they are using MirageOS in production at their startup.

Why unikernels for industry?
* Resource usage
* Security
* Improved infrastructure flows
* Advanced dev tooling
* Simplicity

How do we get there?

First develop it as a unix papplication with a careful eye towards becoming a unikernel. Therefore make sure that all your transitive dependencies do not depend on Unix. However in practise this is quite hard since an existing library might have a transitive dependency on Unix.  Rebuilding application be tricky due to this, so better documentation of the library is needed.  *Anil note: can we have an attribute on doc generation to highlight "mirage compatibility"*

How do we get there?  Currently things are:
* highly artisanal
* hand creafted artifacts as every build is bespoke
* carefully constructed infrastructure
* very difficult to deploy
* low-to-no monitoring at present

However, this is all solvable now given existing public infrastructure, so here's how we can solve this:

### Dependency management

* Basic but foundational for unikernel deployments.
* Opam is not particuarly declarative for a given project with a bunch of global state. *Anil note: Does OPAM2 have a better reproduction story?*
* Seemingly non-deterministic *Anil note: this is likely different solvers, can we encode this into opam export?*
* In a clojure or Node world, dependency versioning is explicit.

In theory, Mirage supports many backends but in practise the different backends need a different dev toolchain.
* Switching between them is quite laborious
* External dependencies not taken care of
* Docker solves this but is another dependency so wary of introducing it, but for shops already using Docker this should be fine.
* This is considered _unsolved_ at the moment *Anil note: should put a gating bug on OPAM2 to ensure this is resolved before OPAM2.0 release*

### Hosting
* Tried EC2 on Xen initially but the primitives and workflow hampered quick deployments
* Hrd to plug unikernels into existing tooling and so benefits are difficult to realise.
* Solo5 (KVM) backend and Google CE has been much more succesful. Upload to Google Cloud storage and upload and boot within minutes!
* Solo5 triggers a rolling update with zero downtime -- very nice.
* This is considered _solved_ with the Solo5/GCE backend.

CI:
* CircleCI used to automate the build and upload to GCE, which works well.
* If dependency management is solved, then this CI setup is near ideal.

Scaling:
* Can use GCE scaling based on CPU usage.
* Launch new instance if CPU > x% for N seconds.
* kill old instances when CPU drops below 5% for a while.
* Health checks to restart every 30 seconds if any installs are stalled.
* Considered solved

### Where do we go next
* On the cusp of being able to production unikernels.
* Nextgen infra need to be unikernel aware
* Unikernels raw boot in milliseconds, but infrastructure stalls it all.
* Whats the point of the benefits if they have hidden it in infra?
* Want "dust clouds" which are swarms of unikernels that boot up and scale fast.
* Google's model is per minute (AWS is per hour), but a website as a unikernel needs something even more fine grained (per second). 
* Because of the immutable nature of unikernels, previous versions can support rollback.

### Ongoing concerns
* Documentation: this is a perennial one in dev communities, but is particularly bad in OCaml.
* Tried to bring a team up to speed in OCaml -- the language is fine, but the packages really lack effective docs and are a mass of types.
* Community:
  * Mailing list and IRC approach, whereas new devs are used to mailing lists and Slack.
  * Need better search and general "modern"
* Mirage goals/priorities are unclear -- its been used in industry (e.g. Docker) but its unclear where support for industry use is put. Where support is visibly placed is important. Team gets pulled in all sorts of directions -- understandable but a concern for adoption.

Onboarding and dev flow are the concerns, but a huge number of concerns have been solved.
Crossing the chasm is a concern -- how will Mirage move from early adopters to the early majority?  The chasm is where cool technology goes to die, and we dont want that to happen!
