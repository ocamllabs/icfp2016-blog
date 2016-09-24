---
title: Creating an approachable Haskell-like DSL
author: seliopou (Spiros Eliopoulos)
abstract: Saturday 24th 1400-1425 PM (CUFP 2016)
---

The use-case considered by the talk is building an DSL that is somewhere between Haskell or OCaml, and YAML or JSON. The main motivation for not using YAML or JSON is a syntax that is more amenable to composition. In addition, many serialization formats such as YAML and JSON do not support comments and in-line documentation, and only offer generic error messages. In other words, using an EDSL allows the implementor to provide langauge-specific syntax error messages as well as errors that result from other static analyses.

Additional design goals include:

* simple things should be simple;
* complex things should be possible in a clean way; and
* avoid building a general purpose programming languagae.

The implemented DSL is a typed langauge that includes records with an update syntax, pattern matching, and functions. Functions support something like named parameters by allowing pattern matching against records in function arguments. Optional named arguments (arguments that have an option type) are also supported via special treatment of the `Option` type, specifically allowing coercion of `'a` to `Option 'a` and vice versa. That same sort of coercion is in a sense "lifted" to record fields, where fields with an `Option 'a` type can be omitted, or just specified by providing a vlue of type `'a`. This is at the cost of principal typing of the inference algorithm.
