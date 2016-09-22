---
title: Malfunctional programming
author: avsm (Anil Madhavapeddy)
abstract: Thursday 22nd 1640-1655 PM (ML 2016)
---

You generate a brand new type system and are very proud of yourself, but then reviewers keep asking you: can you make it _go_, and make it _go fast_? You end up writing a programming language implementation, and often cut corners with your beautiful original semantics.

It would be nicer if you could compile to and target an existing language.  You can compile to a _safe_ language like Haskell or OCaml, or an _unsafe_ language like C. Some languages are safe because of runtime checks, and others are safe because of static types. It can be non-trivial to map your new languages types to the semantics of another static type system (e.g. a dependently typed language crammed into OCaml or Haskell types).  For this reason, it is quite convenient to compile to an unsafe language, because then any bugs are yours and fixable in your type checker.

Unfortunately C is not a good unsafe target as it has no useful things like closures or garbage collectors, and the syntax is not fun to generate either. Every language intended for humans has weird scoping rules and keywords, and for pure generation its often more convenient to have an intermediate form.  Instead of C you could generate LLVM, or System Fc for Haskell, or JVM bytecode for Java.  These are all quite similar to the language you are starting with -- in the case of System Fc, it fits Haskell like a glove, but Haskell has many fingers and interdimensional thumbs and may not work for your language.

In the case of OCaml, the intermediate language is nothing like the core language. The first thing the compiler does post type checking is that it throws away types, and the intermediate language is the untyped lambda calculus. Why dont more compilers target OCaml to use this?  Lambda is undocumented, has no clear API outside the compiler and is generally a bit obscure.

The speaker wrote a concrete syntax (MaLfunction) which is sexp based and can be fed into the compiler. 

```
(let
  (rec
    ($fact (lambda n)
     ...
```

Malfunction has undefined behaviour, but it can always be detected by the interpreter.  This is unlike in C, where there is undefined behaviour but you cannot classify a program by running it into well- or notwell-.

### A backend for Idris

About 20 lines of code, based on the Idris-to-PHP backend (yes this is a thing that exists).  The backend was straightforward to wite.  *Speaker shows a pythagorous triples function as a benchmark*.  When compiled using Malfunction as a backend, it was about 3x to 13x faster than various Idris backends (C backend).  This makes Malfunction an attractive compilation target since you get to use the entire OCaml toolstack!

## Q&A

*Q: (Michael Sperber):* so this is a new Scheme? like Manuel Serrano's bigloo.  Could Scheme be a usable taret?
*A:* Speaker: no. Gabriel Schrer: if you use ADTs then Scheme has no good backend, but Malfunction does.

*Q:* Can you interact with OCaml libraries and modules.
*A:* Yes this creates cmis and cmo cmx files.  The types are not that interesting but they do exist.

*Q:* where is the name from?
*A:* this is a project that started from an entertaining pun and worked backwards to an implementation.

*Q:* the Idris implementation is really Haskell. Idris has a set of intermediate representations and so it is also an untyped lambda calculus. Is this why its so similar?
*A:* ADTs are represented slightly differently so it wasnt non-trivial, but yes, its quite close.




