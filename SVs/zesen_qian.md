---
title: This short example is very practical and appealing
author: Zesen Qian
---

My name is Zesen Qian, an undergraduate from Shanghai Jiao Tong
University, interested in dependent type theory. I just attended the
ICFP 2016 as a student volunteer; it has been a wonderful week for me.

Among all the conference and workshops, I was most impressed by the
PLMW (Programming Language Mentoring Workshop). It's very considerate
of the organizers to run such a workshop for newcomers in this
field. I personally found [the
tutorial](http://dlicata.web.wesleyan.edu/pubs.html#dependent) given
by Dan Licata lots of fun: to implement a type-safe `printf` in
Agda. `printf` originated from the C programming language and has been
a headache since then because a proper call of `printf` requires the
number and types of arguments to match the format string; otherwise,
it may visit a wild memory or a wrong register. In recent versions of
GCC this issue is addressed by type checks hard coded into the
compiler itself, which is ugly because the compiler should not be
caring about the safety of applications of a specific function. It's
also not effective because the trick doesn't work once the format
string is not a literal, or `printf` is indirectly called via
a function pointer.

The key issue here is that, considering the curried version, the type of
the returned function of applying the format string to `printf`,
actually depends on the value of that format string. That is to say,
`printf "%s" : String -> String`, and `printf "%d%s%d" : Int -> String
-> Int -> String`, and so on. This is where dependent type
comes in: in dependently typed language, the type of returned values
of functions can be dependent on value of the arguments; we can first define a
function `retType(fmt)` mapping format strings to the corresponding types(as shown
above), and declare the `printf` 's type to be `(fmt:String) ->
retType(fmt)`. That is, the return type of `printf` depends on the
value of argument `fmt`, which is itself a `String`. Define the
function so that it type checks, and everything is solved
elegantly and effectively (Of course the details are not exactly like
this, but you get the idea).

This short example is very practical and appealing, showing the
potential of application of dependent types in real world programming,
reducing BUGs, tests, and costs.
