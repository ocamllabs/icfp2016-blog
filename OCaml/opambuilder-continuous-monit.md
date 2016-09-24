---
title: OPAM-builder: Continuous monitoring of OPAM repositories
author: gemmag (Gemma Gordon)
abstract: Friday 23rd 1219-1235 AM (OCaml 2016)
---
## Goal
improve the quality of opam repos

- packages should be available for most OCaml versions
- available packages should never fail on build or install

## Current solutions

- Travis on GH PRs: checks that packages modified by the PR can still be installed
- OPAM weather service: checks that dependencies chains are not broken and Camelus opam-bot

**Installations can still fail with the current solutions:**

- new OCaml version - the package does not build with a new compiler version
- new version of dependency - package does not build with a new version of a dependency (API change)
- dependency removal - version was removed, forcing an incompatible change of dependency version

**Continuous testing with opam-builder**
build all packages in almost real time

- 7 OCaml versions - 3.12-4.03.0 plus betas
- all package versions
- almost real time

**Extensible architecture**
opam-builder daemons

- one daemon per OCaml version - builds all packages for a given OCaml version for each repo commit
- one daemon to lint all packages
- all daemons store results of summaries in a directory for easy copy between machines
- one daemon generates web pages from result summaries

not yet tested on windows

**Scalability and realtime**
opam-builder runs on a single server

- 4 cores
- RAM 16gb
- space usage: from 39% to 80% in 6 months, no clean up/GC

### Optimisations

**1:** check only impacted packages

- after each commit, hash every package description
- build approximate dependency tree between packages not versions
- compute the hash of the approximate dependency tree of each package
- check only versions of packages whose hashes have changed
- for each impacted version, compute the exact tree of dependencies
- compute the hash of the exact dependency tree
- build only the versions whose hashes have changed (usually btw 1-50 package builds)

**2:** fast computation of dependencies

- for each impacted version need to compute exact dependencies - calling opam for each package is slow. Solution is to call opam once to get the CUDF universe and call aspcud directly for every other package (10x faster)

**3:** caching previous builds

- short patch to opam to snapshot the switch directory (before and after each build and installation), generated files stored in archives and reuse existing archives where possible

working since march 2016

## Q&A

Q: caching mechanism - wouldn't this be useful in opam itself? If you have many switches depending on the same tree. have to make OCaml look at the build - in one switch that is ok and you can reuse what has been done already. If the directories of the switches are different then it won't work, and if you want to share the binaries between different people. ocamlfind is not compatible with that. Not just opam, it requires fixing a few OCaml packages

Anil: using opam 2 wrappers we have a docker version using file system of docker (support for wrapper scripts present in opam 2)

Q: Green and red demonstrates a vision of the good - if you want to support every OCaml version you can't release new features. What's the notion of a good state referring to all versions? Idea is that if you provide a library, one version of the library should be available for each OCaml version. (Maybe the differences between the green vs light green could be altered).

Q: Should then new library authors now make it run on OCaml 12?
Sometimes I want to go back to an older version. I can wait to use new features until they are available on all versions of OCaml.

Q: quality of the repo - a package is declared to work with a compiler - it should be red. If it is declared to not work with a compiler then that needn't be red.
