---
title: ICFP 2016: All sorts of permutations (Functional Pearl)
author: ciaran16 (Ciaran Lawlor)
abstract: All sorts of permutations (Functional Pearl)
---

This is about writing non-deterministic algorithms, then concatenating all possibilities to get all solutions.

First we will talk about a slightly simpler problem - computing sublists. Computing a sublist non-deterministically is filtering it with a predicate that non-deterministically returns true or false (like a coin flip). Every possible non-deterministic value will then give every possible sublist.

Now we replace the predicate with a non-deterministic comparison function instead. So it's actually a sorting algorithm. This computes a non-deterministic permutation. So all possibilities gives all permutations. However, different sorting algorithms have different behaviour when concatenating all possible results.

**Insertion sort** - This gives exactly all possibilities.

**Selection sort** - Gives some duplicate results. This is because some comparisons are made multiple times, and as it is non-deterministic it can give a different result each time. We want *consistency* - if we make a decision, we should have the same decision later on in the decision tree, by keeping some state about all made choices in our comparison function. This gets rid of the duplicates.

**Bubble sort** - This again gives duplicates. Applying consistency only gets rid of some of them. This is because the relationship we are using should be total (e.g. if comparing 2 and 3 is true then comparing 3 and 2 should be false). So we must make our comparison function smarter by also computing the total closures of all choices we've made.

**Quicksort** -  Requires just consistency to get rid of duplicates.

**Patience sort** - Seems to be unique in that it not only needs consistency and totality (like in bubble sort), but also transitivity.

In the paper:
- Non-deterministic versions of pure functions via monadic generalisation.
- Analysis of different sorting algorithms.
- Inlining of predicates to gain permutations enumeration function.
- Proof that each permutation is enumerated.

Working on proof for exact permutations.

### Questions

Q: You're generating all sublists and permutations, would there be a function that could generate all possible partitions?

A: Some sort of non-deterministic group.

Q: Could you memoize the comparison function instead of keeping the past state?

A: Something to think about but we didn't do it. Doesn't give you transitivity?

Q: What if a stupid sorting algorithm is comparing elements to themselves?

A: Then the comparison function would need to understand reflexivity as well.
