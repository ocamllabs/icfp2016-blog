---
title: Dynamic witnesses for static type errors (or ill-typed programs usually go wrong)
author: your-uid-here (your-name-here)
abstract: Tuesday 20th 1330-1355 PM (ICFP 2016)
---

# Witness visualization

When entering the ill-typed `sumList` function in the visualizer, it shows that
`sumList [0]` implies the ill-typed call `0 + []`.

# Evaluating witnesses

Benchmark: over 4,500 ill-typed programs, witnesses could be found in less than
10 s.

Are witnesses simple? 57 % of traces have less than 5 jumps.

Are witnesses helpful? User study with undergrads at UVA (n = 60): grades were
10 to 30 % better when they used the compressed jump trees.
