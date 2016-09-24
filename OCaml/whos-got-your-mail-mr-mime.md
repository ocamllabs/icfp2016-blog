---
title: Who's got your mail? Mr Mime!
author: gemmag (Gemma Gordon)
abstract: Friday 23rd 1705-1730 PM (OCaml 2016)
---

An implementation of email in pure OCaml

## Features of Email
what is email?
collection of rfcs for header, body etc

fws - folding white space
If you want to describe a value on each line with fws - fusion between the folding white space and the comment - cfws

nested comments and fws - difficult to use ocamllex in this case

email address - complicated - encoding of names with accents for example. can also tag an email to filter by source, can add a comment, add fws, add ipv6 domain in email - becomes very complex already

body - more simple as it is some data.
multipart - one kind of rfc -> content (field); preamble and epilogue (optional)
also multipart inside the multipart - different levels
email with multipart inside of a multipart of another email.....

8 rfc in email
quoted-printable and base64 encoding
illegal and outlook email

## Mr Mime

Email is so complex, you should use mr mime to parse and write an email in OCaml

**Mr Mime:**

- parser combinator: angstrom, planck and pcl. Finds angstrom best
- input: uses a ring-buffer (specialised to a string or a bigstring). Also switches to regular buffer - upscale the size
- api: convenient interface to deal with any parser.

**Results**

tested on 1800000 email
99% success
18 emails per second

Can compose all of the parsers.

**Future Goals of Mr Mime**

Implement a unikernel with mirageos
a good application of this is an smtp client

Could create a zimbra style email client with mr mime

## Q&A

Q: Those outside of the standard - need to add hacks, how did you pile these hacks to reach 99%? It's about the granularity of the parser - you can choose to only parse some part of the email if you wish.

Q: large part of mr mime is parsing and regex - can it be improved by using a faster library or dual parser? I have no serious benchmark for mr mime - it's to see if the parser combination is fast. It is not a parser combinator library, so I focussed on the email.

Q: used uutf8 for encoding and ipv4 parsing. Will something improve the efficiency, maybe mehnir? I need to test some more emails to check performance - next thing to work on

Q: where did you get 2 million emails? From Mort

Q: Complexity like this means you need to build a byzantine API to cover all the bases - how do you deal with that? With the parser combinator, you can select the parser and specialise it.

Q: If the first parser fails, you need to rollback and use the other parser - need to keep all the information to do that. Need to see if you trust the email and continue or not
