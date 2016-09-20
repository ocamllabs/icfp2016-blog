---
title: A glimpse of Hopjs
author: ciaran16 (Ciaran Lawlor)
abstract: Tuesday 20th 1035-1100 AM (ICFP 2016)
---

A multitier programming language for programming web applications - client side and server side. It also can be used for one client and many servers, all communicating with each other. It automatically splits what is executed on the client side and server side.

Based on JavaScript - mostly ECMA Script 5, but with several extensions:
- Built in HTML support, HTML can be inserted directly, understands HTML so will be checked.
- Tilde (~) expressions to indicate it should be executed on the client side. Tilde expressions can be nested.

Server side DOM as well which can be manipulated as normal - can use querying, filtering etc on the DOM.

### Services

Support for web services.

Can create web services which abstracts away GET / POST requests into function calls.

Can also wrap external web services.

### Parallelism in Hopjs

JavaScript isn't multithreaded. Workers and promises to the rescue.

Web workers running in parallel.

Promises can used instead of asynchonrous callbacks. Used for POST etc.

### Questions

Q:

A: Everything is implemented in Scheme.
