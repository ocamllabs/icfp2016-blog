---
title: PLMW 2016: Analyzing JavaScript web applications in the wild (mostly) statically
author: jdjakub (Joel Jakubovic)
abstract: Analyzing JavaScript web applications in the wild (mostly) statically
---
Original paper "Battles with False Positives in Static Analysis of JS Web apps in the Wild"

Ideal program: identify exact set of bugs. Infeasible.

Run on multiple platforms. "Run, Rabbit, Run!" - Minesweeper clone from Tizen. Uncaught TypeError exception if you modify some settings before playing the game. Many web sites have tons of JS errors - just keep console open, and stare in awe!

Score will now have value undefined.

Ebay: product values eg `NaN`

Would obviously benefit from static analysis. Traditionally: we value soundness; include all possible bugs. Which means some false positives.

Some clients used to C, C++, Java ... not JS.

Tried analyzer on apps - 55 true positives 334 false!

One reason: dynamically (runtime) loaded JS code!

Most false positives: W3C APIs, browser-specific APIs, and libs eg jQuery.

For many browser-specific control paths, often not completely exhaustive with respect to different browsers + versions, so does not play nice with static analysis.

### JS File paths

Often, many loaded JS files not actually used. Such as test files for RequireJS.
Others: locale-specific files; only one used at once.

### Snapshot

ECMAScript spec: all code runs in host env; browser or OS platform
Snapshot is a capturing app; get snapshot for each browser. Sound for a given browser and given version.

### Model
Lots of libs. JS freestyle; no / little standardization. Pass any args to functions, implicit conversions, etc. Platform-specific / native code methods e.g. get contact / use SIM card phone services.

Type-based model e.g. with TypeScript. Only looking at function applications, etc. No simulation of side effects. Joins the dots.

3 metrics: precision: 55 -> 91 true positives. 334 -> 240 false positives.

**SAFE:** Scalable Analysis Framework for ECMAScript.
