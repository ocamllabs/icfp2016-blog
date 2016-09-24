---
title: Conex -- establishing trust into data repositories
author: Ciaran Lawlor, gemmag (Gemma Gordon)
abstract: Friday 23rd 1145-1210 AM (OCaml 2016)
---
## Ciaran's notes

Integrity and authenticity of packages - ensuring the user gets exactly what the author released.

### State of OPAM

Focus on OPAM but this is general so can be used with other package managers. Can be applied to other datasets as well.

**Resources** - *packages*, *releases*, *authors* (github identifier) and *janitors* (fix dependencies, merge PRs).

Client wants to know if the package he received was the one they intended to receive.

#### Security

- No trusted link between repository and client.
- Only MD5 checksums of remote archives.
- A janitor currently has complete access.
- Transport to client is insecure.

Threat of malicious injection, or rollback of packages (interesting if one of the packages has a security problem).

### Conex

- Does not require any more complexity in the client.
- Only slight bother to authors.
- Janitors do have to do a bit more work, but some can be automated.
- Need to explicitly deal with keys being lost ("not based on some arbitrary mechanism like expiry dates").

**Resources** - each package now has authorised owners. Owners can modify package names using their key. Janitors are in charge of package names.

**Trust** - Authors and Janitors generate private and public keys (stored in the repository). Initial set of Janitors bootstrapped to opam, can add more Janitors dynamically.

**Repository** - Each package is authorised by a janitor, and release and checksum signed by owner. Includes all files of a release. A single janitor cannot modify packages.

**Teams** - Packages can be owned by owners and teams. Useful for managing lots of packages. Janitors is just a team.

Demo showing Conex from the command line - generating keys, verifying connection (shows missing signatures on package etc), ...

Deployment - waiting for OPAM 2.0 (for validation hooks and compiler as packages).

Current state - basic library implemented.

### Conclusion

- End to end signing of package releases.
- Can be reused (not bound to opam, git, GitHub).
- No need to trust server.
- Signed and unsigned package may exist.

### Questions

Q: Most common workflow - when fixing a package most likely to email author or get a quorum? (Gabriel)

A: Depends on packages, some authors reply quickly...

Q: How should we bootstrap this? (Anil) (Missed some of this question)

A: Can just continue with current OPAM repository and use github IDs to bootstrap public keys.

## Gemma's notes

Library for establishing trust in data repos

**Goal**

- integrity and authenticity of data repositories
- client which downloads what the author released

Want to integrate into the opam tooling, but also more general for other non-opam data repos

**opam repo contains:**

- ocaml packages
- metadata of packages (url, build recipe)
- community adds new packages, releases, fixes dependencies

**resources in the repos:**

- package (identified by name) needs to be unique
- multiple releases
- authors of packages/releases (GH identifier)
- janitors to fix dependencies, merge PRs

Janitors are crucial. If a core package is released (e.g. lwt) there may be hundreds of fixes and reverse dependencies needed

Cute hand-drawn pictures :)

**security state of opam atm**

- no trusted link btw repo and client - tls connection but no certification
- MD5 checksum of remote archives - MD5 considered weak
- single janitor has complete access - e.g. add arbitrary patches and commit - backdoor implementation possible!

**Threats**

- repo server is (hopefully) not compromised
- transport link btw repo and client is insecure (changed upstream with 2.0 and certficate will be validated)
- malicious injection (dependencies, build recipes, source)
- rollback - prevent updates of packages. Interesting if a package has security problems

### Conex
based on update framework of the tor team in 2010

**We want**

- sensible security into the workflow
- no more complexity on the client side
- should not bother package authors extensively as you want them to use the process
- janitors will need to take some of this extra work, but hopefully some of it will be automatic
- deal with key compromises - system should expect it and deal with it - design a cryptosystem with that in mind, not an arbitrary expiry date on certificates

**Resources needed**

- each package will have an authorised owner/s
- janitors in charge of the package name resource
- owners can modify package but have to sign

**Trust establishment**

- authors and janitors generate private and public key pairs
- stored in repo
- initial set of janitors distributed with opam
- dynamic set of janitors - decided by quorum
- clients verify signatures on updates

**Repo**

- each author and janitor: public keys
- each package: authorisation file (signed by janitor)
- each package: releases (signed by owner)
- each release: checksum file (signed by owner)
- includes all files of a release (opam, patches, release)
- janitors can fix packages but quorum needed

**Teams** - of janitors

- name to set of authors mapping - shares same namespace
- owner can be an author or team
- useful for projects with lots of packages e.g. mirage, JS

**Index**

- collection of resource type, name, digest
  - fewer public key operations
  - enable vouching for multiple people

**Design**

- single connection - avoiding multiple connections where any may fail
- similar workflow to now

**Current status**

- Waiting for opam 2.0 release
- can have signed and unsigned packages
- basic library implemented (3rd generation)
- update verification needs work

### Conclusion

- easier than initial proposal in 2005
- not bound to opam or git, or github
- no need to trust repo server
- workflow mostly the same
- signed and unsigned packages can coexist
- initial rollout with opam 2.0

Q: want to modify a package as a janitor - do I email author or I get a quorum - what would be the most common workflow? Anyone can propose a PR then inform either the author or a set of janitors - once it has enough signatures then the PR can be merged. Some authors are responding very quickly, but it can depend on specific package and author.

Q: How can this be bootstrapped with the 4000 packages that are there right now? New opam repo or use current one? Continue with current repo. Initial bootstrap - use Github ids to bootstrap the public keys. Authors with lots of packages, we should be more careful of the initial bootstrapping process to ensure no problems/malicious insertion at that point
