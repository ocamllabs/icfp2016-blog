---
title: The state of the OCaml Platform: September 2016
author: gemmag (Gemma Gordon)
abstract: Friday 23rd 0935-1000 AM (OCaml 2016)
---

Presented by Louis Gesbert

## New Features
local switches - essentially act as a sandbox.  
Uses compiler as switch - allows more custom compilers (coq). Also fits with signing (conex - see Hannes' talk)  
opam switches untied from compiler  

new uses for switches:
  
- compiler: base packages
- root packages no longer have to be installed
- package pinning
- managing package contents
- create empty switches
- Use directories as switch names - switch auto-selected by opam  
- symlinks work  
- wrappers: change how packages work locally e.g. building in containers, creating a cache of compiled binaries, global or per switch.
- error mitigation: remove packages as late as possible, and a command to recover.
- more external solvers supported
- API improvements: easier to write extensions and plugins
- Enhanced CLI query
- File locking system
- define global and switch variables
- in-place builds - good for certain workflows

**almost** no OCaml-specific code - can use OPAM for other projects

**opam files changes**: conditional and parameterized dependencies, export environmental changes using `setenv`

**migrating the OCaml repo:**
3 packages implement OCaml
ocaml-base-compiler: official OCaml release
ocaml-system: wrapper over a compiler installed outside of OPAM
ocaml-variants: compiler variants
virtual OCaml package
opam admin tool handles migration automatically - uses a mirror
automatic compiler choice at opam init (configurable)

## Upcoming features...
- UI tuning for workflows
- windows support
- signing - conex (will have hooks in 2.0 but not full release)
- generation of software bundles
- a `provides` field

## 2.0 roadmap:
1) gather feedback on preview during Oct
2) define workflows to support in Nov (sugar and doc them)
3) beta release in Dec
4) 2.0 in Jan

Gathering feedback:
- bug tracker
- wiki

## Current state

There are >1300 packages available (>5500 including all versions)
250k package installations each month (from their server - private repos don't count towards this number)

**DOCS**
opkg: simple package layout to query readme, changelog, versions
opkg changes cow
opkg ocamldoc: generates single website for all installed packages (docs.mirage.io)
opkg doc on the way

**Workflows**
- local package build: npm-like. Build universe inside sandbox for the project. Possible with preview release as is, but not super convenient. Sugar to be added. Local opam switch with dependencies, artifacts are easier to browse

**Auxiliary tools**:
opam-publish: submit new packages as PRs to repo
opam-user-setup: configure editors (regression possible!) won't mix Merlin between different switches
opam-manager: released soon: wrappers for all commands so they are auto selected from the right switch. Don't need to run opam eval all the time
camelus: opam-bot for errors and warnings when uploading to opam
opam weather service: irill.org
bench.flambda.ocamlpro.com: test new branches of the compiler - needs a little work to be very useful.

Q: software bundles - implementation plan? Not decided yet, different plans. Can use plugin or tool rather than baking it into opam. Standalone archive, easy to build with opam 2.0

Q: Specifying a compiler is odd with compilers as packages.

Q: Do you need help maintaining opam repo? 8 maintainers with a backlog, but a better CI. Testing 8 different Linux distros with Windows support to come soon (once upstreamed) with help from Microsoft. Need help with other OSs, especially on Windows.
