---
title: ICFP 2016: Dynamic witnesses for static type errors (or ill-typed programs usually go wrong)
author: jdjakub (Joel Jakubovic)
abstract: Dynamic witnesses for static type errors (or ill-typed programs usually go wrong)
---

Need to find witnesses that will go wrong.
What types if input should be searching for? Cant do arbitrary input of arbitrary types.

Idea: be as lenient as possible

Rep unknown inputs with holes
Explore execs, refine holes on demand

generate lenient inputs to allow prog as far as possible

sumlist ?xs

```
match ?xs with
  [] -> [] (* uninteresting *)
  y::ys -> y + sumlist ys

?y + sumlist ?ys
instantiate ?y as 1

1 + [] !!!
```

Jump-compressed trace:

```
sumlist 1
1+ sumlist []
1 + []
```

Witness generality theorem

`sumlist` in terms of `fold_left`

end up with lambda term

how many args to apply to input term?

Keep supplying more until it reduces to sth other than lambda

Using "anomaly (?)", prototype. Can view environments, step forward by various increments.

Evaluation:

do witnesses exist? (ill-typed but doesn't go wrong?)
are witnesses simple?
do they help diagnose problems?

Looked at 500 ill-typed small programs from students.

87%, can find witnesses in <=10sec. 75% <=1sec.

Most witnesses did lead to type err. Others led to unbound var err, others just diverged.

57% traces < 5 jumps, 81% <= 10 jumps. So fairly simple.

User study of undergrads learning OCaml. Given 4 ill-typed programs, ask to explain and fix errs.

Group A: OCaml err msg
Group B: trace

"Students perform 10-30% better with traces"

Q: somelist example can be corrected with ++ instead of + - only the name sumlist says it's a sum.
A: True.

Q: As a professor, can you come up with smaller traces than 10 steps?
A: Think so. If use [1;2;3] instead of [1], well, we use random generate of witnesses, so could vary.

Q: What if run into other problems eg div0 - tell about these too?
A: Of course could report the others too.

Q: Not all type errors. if x=y then 0 else false. Context-dependent, Synthesize context to show wrong?
A:

Q: If use this, must give ppl actual type errs too, since not always have witness?
A: Yes

Q: Challenges to adopt this for runtime errors?
A: Similar approaches. Random search? Exhaustive? Bounded? Symbolic execution? Tools exist to do this already. Type errors have been treated historically as "don't even bother to try run it."
