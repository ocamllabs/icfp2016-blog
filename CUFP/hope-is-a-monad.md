---
title: Hope is a monad
author: gemmag (Gemma Gordon)
abstract: Saturday 24th 1705-1755 PM (CUFP 2016)
---

An experience account of successfully using FP in various different settings.

## Modelling market data transformations

Scheme 48 - implementation of Scheme but experimental - worked on it in 2004.

Market data focus for pricing calculations. Volatilities measure how much a given quantity changes over time - inferred from simple financial derivatives called calls and put options. You now get entire volatility surfaces - but if you want the parameters, you will need to use interpolation to estimate these.

### Object-oriented approach
Traders want to have a robust portfolio so play scenario games. I was involved in writing the software to help traders imagine these scenarios - from the C++ team. Object hooked up to current market feed to get the current price or the current volatility. Traders don't want the actual source of market data at runtime, so dynamic subclassing was used. object-oriented programming approached so used decorator patterns to create a subclass of the class you want to extend, create methods and then overwrite those methods and chain decorators together. BUT this uses recursive calls, leading to double calls. Interesting to a functional programmer! How can we fix this?

### FP approach
Modelling market data transformations correctly - use regular function composition - worked brilliantly over the object object-oriented model.

Combinator models used in many situations/projects

 - financial derivatives
 - access rights
 - stage lighting - Lula system for stage lighting design and control
 etc LONG list

## Using FP for scheduling in a fabrication environment
Scheduling for semi-conductor fabrication. Semi-conductor manufacturing process is very complicated with thousands of production steps.

Code to handle hope - monad model

 - shattered
 - fulfilled
 - deferred (new hope)

Queue time traces
Entering a queue time zone you need to decide

 - risk it
 - delay for congestion/block to clear
 No modern scheduling system handles this problem directly - can simulate the process to see what occurs = QT simulation with nesting by wrapping QT scheduler around an internal progress scheduler. Communication between schedulers

 How to structure and compose schedulers
 - input -> output
 - underlying state
 - consumes fab notifications
 - produces fab instructions

Created a scheduling network - purely functional fab in an industrial setting
GUI can get very complicated
Used React - React uses JS and is 80% FP so used it as a wrapper around their GUI called Reacl. Re-worked the MVC model to include efficient updates in the browser solving lots of problems present with a mono view controller.

Need to use model containing the application state, but need to make it modular and not monolithic. So declared a class of GUI items/widgets which specifies a render expression to covert that app state into HTML. Lots of tooling to help with CSS and HTML available that they used. Callbacks send a message to one of the GUI components and the class will receive that message and declares the new application state - this works well.

Separating the GUI logic from the application logic - takes the user intention and turns that into a change in the application state. Testing JS is difficult so this abstraction helps.

Underlying message of purity - using FP for all the things

Configuring mobile devices automatically is difficult to coordinate especially wrt printing, network drives and other configuration components. No ubiquitous network connectivity too. You only want to configure a device once and you want each tablet to know the configuration and synchronise amongst eachother. Implementing pair-wise synchronisation between thousands of devices helps to keep this simple. You want a fresh communication each time they meet -> this requires an immutable database as you are building a large distributed system. You want to store facts and synchronise those and develop a conflict resolution strategy -> this involves ensuring that each tablet/device only receives the facts that it doesn't already have by only synchronising the blocks that each device doesn't already have - using merkle trees. Data blocks get given a hash in a tree, each hash is a unique identifier for the data block underneath, and you move through the tree levels depending on the comparison between blocks. Used F# code to run on .net. As you communicate during synchronisation you transfer a fingerprint of the composite hash and work downwards.

It's a purely functional algorithm and it is eminently testable. Use a quick check test which generates two sets of blocks and it applies synchronisation to them, hope they are disjointed and then the union of them is the completed step - helped them to weed out bugs easily.

Windows is still a bit of a nightmare though!

Problems they did have:
- auto configuring printers - what if the devices are moving location frequently
- mounting drives
- track the changing environment

All above problems are caused by mutable states

Takeaway: FP is successful for implementing ALL kinds of software!

Purity - better to get by without using object-oriented programming - it is not a good fit for semiconductor manufacturing for example! Purity enables you to be systematic in your software development and part of being systematic is developing using types in your design. Static typing makes it difficult to be systematic at the type level and the compiler doesn't pass it - dynamic typing may be a better fit.

## Q&A

Q: FP is better but what about when a real-time aspect is necessary? Not encountered those type of applications yet but it might be simply a matter of the existing tooling. If it is a tiny platform then the tooling might just not exist yet - I would say it is a tooling restriction not a restriction of a FP approach.

Q: React framework is incremental updates based on equality checking inputs - did you do anything different here? No but that does relate to the layer we put on top of React. We don't think of our GUI in terms of incremental updates - more in terms of pure functions. Perhaps you can improve performance with a different approach but it hasn't mattered specifically for us.

Q: Galois has Atom to help with that by generating C code which could be helpful. Yes it's not quite satisfactory but it is better than programming in C by hand.

Q: There are connotations associated with monads. Yes, but giving monads a more approachable name isn't the way to do it.
