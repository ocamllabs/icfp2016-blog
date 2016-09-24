---
title: Building a web application with continuation monads
author: your-uid-here (your-name-here)
abstract: Saturday 24th 1210-1235 AM (CUFP 2016)
---

DWANGO is a system built by speker. It has a variety of services such as e-books and side services like video and live streaming. The functionality for user management has been aggregated into the account system.

The account system is for many services and sits on many devices, so needs several interfacs.  So wanted a component technology to factor out code.

There are quite a few filters available in existing web middleware stacks. The problem is that the component technologies dont compose well and lots of information needed by a filter isnt easy to get by.  So we built a new one using continuation monads in Scala.

A continuation represents the rest of the computation at a given point in execution. In Scala, a continuation monad converts a function that receives the continuation into a monad. 

For example, for authentication verification: it assumes that a user logs in elsewhere and there is a session in HTTP cookies before this operation. The session information is stored in Redis, and the component compares the cookie information and the server db to check whether the user is authenticated.

The sequence diagram is: web browser -> web server -> authentication -> filter -> main processing.
The code in Scala looks pretty straight line since written in a monadic style.

Compression is another good example of using the monad.
