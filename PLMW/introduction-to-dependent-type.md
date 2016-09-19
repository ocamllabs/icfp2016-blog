---
title: Introduction to dependent types
author: jdjakub (Joel Jakubovic)
abstract: Sunday 18th 1430-1500 PM (PLMW 2016)
---

Kyan: a language for dependent types by Lenoard Angessen (?)

Idea: type-safe printf!

Dependent types: Types that refer to programs. Agda as example

What if these programs have side effects? Handle specially...

```
data Tag : Type where
  `unit : Tag
  `nat : Tag
  `string : Tag
  `list : Tag -> Tag
  _`{\times}_ : Tag -> Tag -> Tag
```

```
Data : Tag -> Type
Data `unit = Unit
Data 'nat = Nat
Data `string = String
Data (`list t) = List (Data t)
Data (t1 `{\times} t2) = Data t1 \times Data t2
```

```
somedata : Data ( `nat `\times `list `string)
somedata = 5, ("hi" :: [])
```

```
toString : \forall (t : Tag) -> Data t -> String
toString `unit d = "()"
toString `nat Z = "0"
toString `nat (S d) = "1+" ^ toString `nat d
toString `string d = d
toString (`list t) [] = "[]"
toString {`list t) (x :: xs) = toString t ^ "::" ^ toString (`list t)
toString (t1 \times t2) d = toString t1 (fst d) ^ toString t2 (snd d)

printf "%s, you signed up for %d talks today %l%s" ("Dan", 2, "Types of types" :: "A taste of deptypes :: [])

Args : List Char -> Tag
Args s with parseFormat s
  | Some (f, rest) = f `\times Args rest
```
