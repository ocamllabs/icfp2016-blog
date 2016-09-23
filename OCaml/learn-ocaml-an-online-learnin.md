---
title: Learn OCaml: An online learning center for OCaml
author: avsm (Anil Madhavapeddy)
abstract: Friday 23rd 1000-1025 AM (OCaml 2016)
---

Try OCaml
* nice tool for advertising OCaml and jsoo
* starting to show its age and is difficult to maintain

OCamlTop and OCaml WebEdit
* various attempts at a beginner experience
* not much traction

The OCaml MOOC has had 1000s of students in the past two years, and several
students commented that they stayed for the end of the course due to the
interactive environment. They could run completely in the browser and not have
to install any local software.

There is a new version of Try OCaml that is now more maintainable:
* there is an uptodate OCaml compiler version
* it has a new polished responsive design and outputs highlighting
* the toplevel cannot crash your browser as it runs in an isolated webworker
  threat and so cannot block the UI

It has a revamped OCaml MOOC exercise environment with an editor with colors
and forced indentation and automated grading in-browser.

*demo of app in browser with responsive tablet / phone UI*

Demo highlights:
* warnings are tied to the location in the source phrase with little html identifiers
* colors distinguish output, errors, source and warnings clearly
* infinite loop kept UI responsive
* amazing camel icon animations in loading screens
* ocp-indent is enforced so there is normalized syntax, which went well for student learning since they had no preconceived opinions about it

Try OCaml has a set of exercises that students can walk through, and also
supports grading to get a report of progress activity.  They can be shared socially also.

## Distribution

There is a public instance that is hosted by OCamlPro at <http://try.ocamlpro.com/learn-ocaml-demo> with community contributed content.  The app can be deployed locally. License is AGPLv3, and on GitHub at <https://github.com/ocamlpro/learn-ocaml>, and the content repository is on <https://github.com/ocamlpro/learn-ocaml-repository>. Contributions are welcome...

