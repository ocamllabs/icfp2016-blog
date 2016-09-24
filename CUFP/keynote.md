---
title: Keynote (Yaron Minsky)
author: avsm (Anil Madhavapeddy), gemmag (Gemma Gordon)
abstract: Saturday 24th 0920-1015 AM (CUFP 2016)
---

## Anil Madhavapeddy notes

Opened with discussion about types and static vs dynamic.  But FP still not
popular. Go to a top school and its something they have heard of, but still
something that still isnt part of the fabric of the computing world.  Something
problematic about the view that you have to sneak the technology in.

Something worth separating is influence vs popularity.  Many widespread ideas
have started in FP and gone mainstream (Lisp had GC first). The other form of
influence is idioms -- ideas about how to program.  For example, the value of
immutable datastructures hhave shown up in many places such as React.js.

Where FP ideas are used, its often lipstick on a pig, where FP is used to paper
over poor infrastructure.  These are often huge industrial scale efforts that
represent amazing projects, for example Facebook pouring so much work into PHP.

**FP is a perfectly good general purpose tool** and shouldnt be viewed as a
narrow niche. Jane Street is a good example of a place that does it, or Erlang
at Whatsapp. Computer Sci is in many ways a mathematical design process (like
architecture) more than a scientific discipline. The evidence isnt in yet about
whether FP or imperative is better or worse.

**You cant value what you dont understand**, which is a problem for FP.  For
example, Yaron wasnt excited when GADTs were added to OCaml. "Im a systems
programmer, I dont care about types!". But it turns out that they are really
good for optimisation, and also they made a bunch of complex encodings
involving existential types much simpler.  The addition of the feature to the
language was worthwhile despite being initially daunting.

**The right tool for the organisation.** you want to maximise various forms of
sharing and the power of the individual developer. Having a small number of
tools and developing shared standards so people are transportable between areas
is enormously freeing for managing and evolving the organisation. Companies
that standardise in their language choices (e.g. Google with C/C++/Python/Go)
do have an advantage (despite not agreeing with Google's particular choices).
In a company, the individual speed with which you can do the job matters, but
you also need other people as you scale up. This leads to the cost of
collaboration increasing as you communicate more.

**You broke it, you bought it.** When JS was first hiring, they pulled in lots
of early staff who were really good functional programmers.  Later they started
hiring from schools fresh graduates and also people who arent traditionally
programmers. The base grew from dedicated programmers to people who are
learning FP for the first time. The hard bit about working on a minority
language is that you have to foster community. JS has spent a lot of time
funding the building of infrastructure that they do not use directly.  For
example, OPAM is a package manager funded by Jane Street that built a community
around OCaml but isnt directly used at JS. But the community is enormously
important as a source of growth and ideas.  The result has helped them hire as
well.

For organisations in this position, Yaron recommends that you do not take a
narrow view of what you need. Its valuable to foster them more generally and
then benefit from having a seat at the table for them to listen to your
concerns over the longer term.

**Academia isnt academic**: There is a back and forth between industry and
academia for various things (e.g. Incremental) and its important that this
be bidirectional. Learn from academia but also tell them when your realworld
problems dont fit their worldview.

**Teach your children well**: large number of schools teaching functional
programming as a core part of their curriculum. But there's still something
tenuous about the state of affairs, since functional programming still isnt
recognised as a really important part. The people who care most about FP are
the ones who study it, so they tend to teach it more. But if you as a non
academic care about hiring and industry option, then can help by building
community.  For example, resources like Stack Overflow and other shared
knowledge bases take a lot of people to contribute in (try OCaml vs Java in SO
to find the scale difference).  Jane Street has an OCaml bootcamp where they
have lots of tooling to help beginners. Go is a fairly uninspiring language
with amazing tooling to make the programmer productive. Its easy from a POV
that values the language to underestimate the important of tools.

## Gemma Gordon notes

Keynote CUFP: Yaron Minsky

functional programming still not popular
influence vs popularity - FP is influential

limitation of functional languages in the real world
often adopted to improve the experience, but "lipstick on a pig"
Facebook - lots of great projects to make PHP better for example.

FP perfectly good general purpose tool. The way in which it is limited is connected to the research world of FP where it focuses on compilers, formal testing, syntax etc

WhatsApp -> erlang
Twitter -> scala
new langs have repackaged the FP ideas for general purpose things
Facebook -> Reason

No good way of obtaining good evidence that FP is good at what it does. What matters is experience and scale - which you can't get in the lab. Small timescale with small projects so experimental evidence is difficult to come by. Compsci is a mathematical engineering project rather than a "science"? Projects using FP in real world are social in nature. Also difficult to value FP ideas if it's not already well understood. Examples and success stories are not convincing in terms of evidence - there are many imperative programming success stories over functional programming stories. If the ideas and projects haven't been widely used,

GADts added to OCaml - Ron not excited initially - made by compiler editors, type system nonsense. But GADTs are great for optimisation, controlling memory representation. Existentially qualified type variables in OCaml - also useful - not accessible previously in OCaml or ML. The workaround sucked did not improve performance.

Importance of looking at other programming language ideas and see if they can help and inform your own work.

"right tool for the job" -> idea that we need lots of different tools for solving different jobs is mostly a mistake. Need a variety, sure, but there are some programming languages that are more broad spectrum than others. Want to maximise sharing and flexibility within the organisation, and having a small set of tools that your team can get to know and are shareable with other groups/projects/people/organisations is important. Focussing on a small set of languages is helpful, but will depend on scale - the speed at which you can do things often dictates.

Programming is inherently collaborative and social - more costs from interactions and changing individual pieces. Need to think about what it means for your organisation, not just the individual, when choosing technologies.

OCaml type system allows you to get by without testing - like JS did for a while - but as they got larger then needed to change that behaviour. Hiring people in more diverse ways, not necessarily FP. When growing larger than the small tight knit like-minded people who might think differently.

Using a minority language is difficult - poor set of tools, shared understanding and libraries. JS recognised that as their use of OCaml ramped up they wanted/needed to support the OCaml community. Taking a broad view is important - funding building infrastructure e.g. opam that JS won't actually use. OPAM is transformative, but has no role in terms of JS core toolset, but it is important for the community -> become more vibrant. Not worth making a narrow calculation when supporting the community - especially when involved with a minority language.

Relationship between academia and industry (Ron's background is distributed systems). Projects are well fit to the problem space - good programming languages were more discovered than invented. ML descendents are generally good/sensible options - certain amount of luck - but the academic world does have a lot of interesting things to say about programming languages and how they can be used pragmatically.
Incremental and reactive programming - a really important pragmatic problem to solve - the academic viewpoint has been very valuable for JS e.g. Incremental and the academic perspectives they sought.
There is also a lot that academia can learn from industry - a difference in focus, perhaps between syntax (academia) and performance (industry). Problems at scale are not well represented in academia, along with other software engineering issues/problems - so sharing information is useful and important.
Academics have reasonable ideas about how to design features etc, but practitioners are working from a different perspective and focus on the human-engineering side of it and using it at scale.

Teaching PL - important to Ron. Text adventures is a fun option!
Teaching FP in schools - one way of distribution of FP ideas. FP not widely recognised and understood as a discipline. IF you care about the language community being successful, then focussing on tooling used for teaching PL is important. Separate from the tools, need to be able to access a shared knowledge base eg. stack overflow (thin on the ground for a minority language).

JS have bootcamp for non FP programmers - quite successful due to their focus on the good tools. E.g. the tooling behind Go is excellent, even if the language is uninspiring to PL enthusiasts. Tooling should not be underestimated.

When working on practical projects using FP ideas, it's not worth focussing on evangelism as a tactic for convincing others. It can take a very long time - eg. parametric polymorphism has a 35 year gap between invention and use. In the short term, focus on succeeding using your FP language and tools. Success stories only add up over time, not in the short term. Short term focus on success, and long term strategy focus on increasing adoption etc.

Q:You mentioned that you don't use opam, and you release a lot of packages on Github - have you tried building them using the tools that exist outside of your organisation. There is a lot of current work on CI for opam packages - and it tends to work more smoothly. The primary thing we are doing is taking our internal tools e.g. Jenga build system and are making it usable outside of JS. The reason we don't use opam is a subtle one - it's useful to have single monorepos for managing codebase as it's simpler. This is incompatible with the opam workflow, and other open source projects. Also you can avoid having to use a constraint solver when engineering software.

Q: OCaml was at first an experimental language and now it is THE language that you use - at which point did you decide that, and when did you decide to write/build your own tooling rather than using the tooling that exists already. The move to OCaml was taken after serious thought and discussion about how vital the community was, and how practical the move over would be. The work on tooling has been incremental - but it comes down to the question of what is best for the company.

Q: gathering evidence about the value of a PL - JS is in a great position. Have you collaborated with/any studies with any people from the imperative programming community. He's skeptical - JS didn't use FP previously, and the software they use has significantly improved the company etc BUT no evidence - it was a rewrite, different people, rewrites are always better etc. How can you construct any useful empirical data on the subject? Has not thought/come across a well thought out technique for this - social science is hard, and social science about things which are hard to do e.g. switching programming languages is hard to do

Q: If the organisation is big enough, there is so much existing infrastructure that you can use to create great projects - it's a chicken and egg situation. You can either start small and build that way or you can try and convince an existing organisation to build the project differently eg switching languages. If you want to do well you need to optimise for the organisation not just for you.

Q: JS is not proof of using FP as success, but it is proof that it's not a failure option. Yes!

Q: Which languages/systems that this community isn't looking at but which we should? There is insufficient communication between the untyped and typed communities - the statically typed world can learn a lot from the macros systems. I feel personally that I should learn more about the proof systems eg. Coq. I don't have a long list of things - in general it's good to poke around and look at systems you might think wont' be good and see what you can find compelling there. There is always things to be learned. Learn from C++ and C about performance - and understand how you can make your language perform quicker - need to think about machines.

Q: How hard to push FP at non specialists - eg. the machine learning community who love Ruby and Python. Eg. getting data scientists to work on something that can be put into production would be difficult/not worth it? We haven't succeeded in doing it - ecosystems are valuable and difficult to replicate. Think about the workflow - and see if it would actually be easier in a different language (making them move over) or just let them work on that in their area instead.

Q: what is coming up from academia within OCaml that you are excited about? Flambda is very exciting, improving IDE functionality and integrating upstream into the compiler is great. Modular implicits which fits nicely in ML is useful. Work on effects tracking in OCaml is exciting but I'm slighty sceptical. The new projects bring up enormous questions about how to build libraries - which are incredibly useful. It has taken time to fully use the features present in a language e.g. GADTs and first class modules - might initally be things you might not know about/have thought would be interesting or good.
