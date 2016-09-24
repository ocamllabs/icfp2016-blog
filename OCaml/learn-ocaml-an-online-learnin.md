---
title: Learn OCaml: An online learning center for OCaml
author: avsm (Anil Madhavapeddy), gemmag (Gemma Gordon)
abstract: Friday 23rd 1000-1025 AM (OCaml 2016)
---

## Anil Madhavapeddy's notes

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

### Distribution

There is a public instance that is hosted by OCamlPro at <http://try.ocamlpro.com/learn-ocaml-demo> with community contributed content.  The app can be deployed locally. License is AGPLv3, and on GitHub at <https://github.com/ocamlpro/learn-ocaml>, and the content repository is on <https://github.com/ocamlpro/learn-ocaml-repository>. Contributions are welcome...

## Gemma Gordon's notes

Benjamin Canou: Learning OCaml
OCamlPro

### Previous teaching resources
Learn OCaml builds on previous experiments:

- try OCaml: first user-friendly toplevel in the browser. Becoming unmaintainable
- OCamlTop, OCaml WebEdit: beginner oriented, general-purpose environments
- MOOC: auto grading, runs in the browser (no install)

### New version of Try OCaml:

- new OCaml version with easy future upgrads
- polished UI with responsive design and output highlighting
- does not crash/hang browser: keeps UI responding and runs in an isolated thread.
- revamped MOOC exercise environment: nicer interface with editor features

Adapts to different devices - can start app on laptop, then use on tablet.

Save progress in a single file - json file which can be restored on a browser

10 animations between loading screens that are AWESOME

**Try OCaml**
collection of tutorials with steps - add code to toplevel and edit

**Lessons**
Not online yet...

**Exercises**
- editor, toplevel, report, exercise (in bar across top)
- ocp-indent is enforced - helps with learning syntax skull if it doesn't type check
- will grade exercises - shows progression and you can correct exercises. Detailed reports.
- Overview on dash of progression

**Toplevel**
- error highlighted in the code and in red - easy to see
- warnings highlighted in the code and orange (MOOC students complained about error highlighting in the output before)
- infinite loop protection - response immediately asking to resolve
- will flood output to 4kb then will ask to resolve

### Distribution
* main public instance called Learn OCaml
  - community contributed content
  - demo at ocamlpro
  - ocamlpro/learn-ocaml
  - AGPLv3 license

Exercises of MOOC not yet public

Contributions needed
- try OCaml lessons
- exercises
- translations

**Future features**
- local or distant saving mechanism with locally cached content for offline use; progression saved/shared on a server.

Registration for MOOC still open

Q: Ron: Impressive. Have you talked to Profs/teachers? US teach OCaml seriously and could use this.
Yes - Boston College. Interns porting exercises. More interaction planned

Q: Did you look at content on OCaml.org - 99 problems etc. Mainly focussed on platform, need to add more exercises as plugging exercises from MOOC atm. Not sure if they can import them, might need more content. Will look at ocaml.org.

Q: How easy to write exercises and graders? Some videos that Benjamin has done - Check these! Difficult to start writing as unsure of exclusivity of the graders - gets easier. html exercise code, then grading code.

Q: Can you provide solutions for particular exercises to enable them to move forward? Graders written in OCaml and can write own combinators which provides freedom. Can show information on solution in report, but no current built in solution yet

Q: Author citing not supported - should be added

Q: Solutions not linked to platform - ok with license.
