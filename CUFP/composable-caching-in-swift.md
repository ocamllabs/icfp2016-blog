---
title: Composable caching in Swift
author: your-uid-here (your-name-here)
abstract: Saturday 24th 1520-1545 PM (CUFP 2016)
---

Virtual caching on keys, and want to make it into differnt types.  Have a monoidal interface to this so can express as maps, etc.
Hooking everything up gives us monoidal caching which transparently handles disk and memory caches.

The composition looks fairly straightline in Swift:
```
diskCache.compose(netcache)
let diskandNetImage = mapValues(bytesToImg, imgToBytes)
return ramCache.comopse(diskAndNetImage)
```

However the problem with this is that if surge traffic comes in then in-flight requests will storm simultaneously (i.e. 10 reqs will result in 10 network reqs). So we need a dictionary to cache inflight requests. Code pretty simple (except GC of dictionary but thats separately handled). Now with the smart network cache requests are not duplicated across requests.

```
let optimisedCache = diskCache.compose (netCache).reuseInflight(dict)
```

[Carlos caching](https://github.com/WeltN24/Carlos), an open source swift library. There is a Purescript implementation to help formalize these ideas.  Cache is a profunctor with respect to the values and a contravariant functor with respect to the keys.

## Q&A

Q: Two processes do two sets. Do a set on a composition to do two concurrent sets. How do you avoid two concurrent processes setting up subvalues? 
A: Yes that would be bad.

Q: Looked at interaction with Twitter Finagle and other systems for integration?
A: Not built it but good idea and should explore as the theory matches well.
