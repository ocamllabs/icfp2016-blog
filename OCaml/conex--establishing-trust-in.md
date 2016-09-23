---
title: Conex -- establishing trust into data repositories
author: your-uid-here (your-name-here)
abstract: Friday 23rd 1145-1210 AM (OCaml 2016)
---

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
