(* Build a Git skeleton of ICFP blogs from the issues *)

open Lwt
open Cmdliner
open Printf
open Astring

module T = Github_t

let basedir = "./"
let repo = "https://github.com/ocamllabs/icfp2016-blog/"
let issues = repo ^ "issues/"
let uri = "http://icfp2016.mirage.io/"

let findl all issue labels =
   List.fold_left (fun a day ->
     match a with
     | Some a -> Some a
     | None -> 
        try Some (List.find (fun d -> day = d.T.label_name) labels)
        with Not_found -> None) None all |>
   function
   | Some r -> r.T.label_name
   | None -> failwith (Printf.sprintf "None of [%s] found in issue %d"
               (String.concat ~sep:"," all) issue.T.issue_number)
 
let day_of_labels =
  [ "Sunday 18th"; "Monday 19th"; "Tuesday 20th"; "Wednesday 21st";
    "Thursday 22nd"; "Friday 23rd"; "Saturday 24th" ] |> findl

let ampm_of_labels = ["AM";"PM"] |> findl

let events = 
   ["HOPE";"CUFP";"Erlang";"FARM";"FHPC";"Haskell";"HIW";
    "ICFP";"ML";"OCaml";"PLMW";"Scheme";"TyDe";
    "Tutorial T1"; "Tutorial T2"; "Tutorial T3";"Tutorial T4";
    "Tutorial T5";"Tutorial T6";"Tutorial T7";"Tutorial T8"]

let url_of_event = function
  |"HOPE" -> "http://conf.researchr.org/track/icfp-2016/hope-2016-papers"
  |"CUFP" -> "http://cufp.org/2016/"
  |"Erlang" -> "http://conf.researchr.org/track/icfp-2016/erlang-2016-papers"
  |"FARM" -> "http://functional-art.org/2016/"
  |"FHCP" -> "http://conf.researchr.org/track/icfp-2016/FHPC-2016-papers"
  |"Haskell" -> "https://www.haskell.org/haskell-symposium/2016/index.html"
  |"HIW" -> "https://wiki.haskell.org/HaskellImplementorsWorkshop/2016"
  |"ICFP" -> "http://conf.researchr.org/track/icfp-2016/icfp-2016-papers"
  |"ML" -> "http://www.mlworkshop.org/ml2016"
  |"OCaml" -> "http://ocaml.org/meetings/ocaml/2016/"
  |"PLMW" -> "http://conf.researchr.org/track/PLMW-ICFP-2016/PLMW-ICFP-2016"
  |"Scheme" -> "http://scheme2016.snow-fort.org"
  |"TyDE" -> "http://conf.researchr.org/track/icfp-2016/tyde-2016-papers"
  |_ -> "http://conf.researchr.org/home/icfp-2016"

let is_tutorial l =
  String.with_range ~len:10 l = "Tutorial T"

let event_of_labels = findl events

let parse_title issue t =
   match String.cut ~sep:": " t with
   |Some (time,title) -> time, title
   |None -> failwith (Printf.sprintf "bad title in issue %d" issue.T.issue_number)

let all_issues = ref []
let write_file fname b =
  let fout = open_out fname in
  output_string fout b;
  close_out fout;
  print_endline ("Wrote " ^ fname)

let title_dir title =
  String.with_range ~first:0 ~len:30 title |>
  String.Ascii.lowercase |>
  String.fold_left (fun a b ->
    let is_ok = function |'a'..'z'|'A'..'Z'|'0'..'9' -> true |_ -> false in
    match b with
    |' ' -> a ^ "-"
    | b when is_ok b -> a ^ (String.of_char b)
    | b -> a) ""
 
let generate_page user repo issue =
  all_issues := issue :: !all_issues;
  let issue_labels = issue.T.issue_labels in
  let day = day_of_labels issue issue_labels in
  let ampm = ampm_of_labels issue issue_labels in
  let event = event_of_labels issue issue_labels in
  if not (is_tutorial event) then begin
  let time,title = parse_title issue issue.T.issue_title in
  let tdir = title_dir title in
  let fname = Printf.sprintf "%s/%s/%s" basedir event tdir in
  ignore (Sys.command (Printf.sprintf "mkdir -p %S" fname));
  let tmpl = Printf.sprintf
"---
title: %s 2016: %s
author: whoami (Anonymous)
abstract: %s
---

This is the template for you to liveblog about the talk,
which is at [%s](%s) on %s %s %s.  You can replace all of this text
with your notes about the talk!

Some useful things to record in a liveblog are:
* the general flow of the speaker's explanation
* background summaries or links that would be useful to a reader
  that has not read the paper.
* any questions the audience asks which may not be recorded correctly
* the URL to the paper, which could be found on the [ICFP preprint](https://github.com/gasche/icfp2016-papers) repo.

There are a couple of ways to contribute your text to the ICFP 2016 liveblog.
First check GitHub [issue #%d](https://github.com/ocamllabs/icfp2016-blog/issue/%d) and
add a note that you are blogging to let other people know.

If you are familiar with the [Git](http://git-scm.com) CLI, then:
* git clone <https://github.com/ocamllabs/icfp2016-blog.git>
* copy this template into `icfp2016-blog/%s/%s/<your-userid>.md` where you can record your notes.
* You can push this file regularly or issue a pull request at your own pace.

If you prefer a web UI:
* navigate [to the GitHub for this talk](https://github.com/ocamllabs/icfp2016-blog/tree/master/%s/%s)
* click on *Create a New Page* and name it `<your-github-user>.md`
* place the header below at the top of the file, and then add your notes.

```
---
title:
author: <your-id> (your-name)
abstract:
---

your notes
---
```

Do not forget to push your notes back to the <https://github.com/ocamllabs/icfp2016-blog> repository.
Anyone who wishes to contribute is most welcome to liveblog here, and do not worry about your notes
being in rough shape; this is expected for a liveblog!

If you want direct push access to the repository, please contact
Anil Madhavapeddy <avsm2@cam.ac.uk> or Gemma Gordon <gg417@cam.ac.uk> and
we will add you.  If you do not have access, just send a
[pull request](https://help.github.com/articles/about-pull-requests/) and we will merge it.

" event title title event (url_of_event event) day time ampm issue.T.issue_number issue.T.issue_number event tdir event tdir in
  let fname = fname ^ "/template.md" in
  write_file fname tmpl;
  let fname = Printf.sprintf "%s/%s/%s.md" basedir event tdir in
  let tmpl = Printf.sprintf
"---
title: %s
author: your-uid-here (your-name-here)
abstract: in %s 2016 at %s %s %s
---

There is currently no liveblog summary available for this talk. You can:

* view in-progress summaries [in the Git repository](https://github.com/ocamllabs/icfp2016-blog/tree/master/%s/%s/)
* track the [GitHub issue](https://github.com/ocamllabs/icfp2016-blog/issues/%d) for this talk
* contribute your own notes by copying the [template](%s/template.md) for this talk.

Some useful contributions before the talk include:
* a link to an open access preprint PDF (see [here](https://github.com/gasche/icfp2016-papers))
* background information you might feel will help readers understand the talk better

During the talk, some useful things to record in a liveblog are:
* the general flow of the speaker's explanation
* summaries or links that would be useful to a reader that has not read the paper
* any questions the audience asks which may not be recorded correctly

If you find yourself confused by Git, you are not alone. Find a nearby functional progammer
to assist you with the fine art of issuing a [pull request](https://help.github.com/articles/about-pull-requests/).

" title event day time ampm event tdir issue.T.issue_number tdir in
  write_file fname tmpl;
  end

let generate_indexes () =
  let tmpl = Printf.sprintf 
"---
title: ICFP 2016 Liveblog Index
author: Gemma Gordon, Anil Madhavapeddy, Gabriel Scherer
abstract: All the liveblogs
---

Welcome to the unofficial [ICFP 2016](http://conf.researchr.org/home/icfp-2016)
liveblog!  This is a resource intended to capture the live notes of activity
across the hundreds of talks that will be given at ICFP 2016 in Nara, Japan.
Any attendee of the conference is welcome to contribute their notes here, and
we will aggregate them after the event into an archive.

To contribute, please click through to the individual talks in the list below:

%s

Some useful resources:
* ICFP preprints: <https://github.com/gasche/icfp2016-papers>
* Conference website: <http://icfpconference.org>

The site data is stored in a plain-text Git repository at <https://github.com/ocamllabs/icfp2016-blog>.
It is served via an OCaml [MirageOS](https://mirage.io) [unikernel](https://en.wikipedia.org/wiki/Unikernel) 
running on [Docker Cloud](http://cloud.docker.com).  The blog software is the [Canopy](https://github.com/engil/canopy)
system built by (Enguerrand Decorne)[https://github.com/Engil] during an internship at [OCaml Labs](http://ocaml.io)
in Cambridge.
" (String.concat ~sep:"\n"
    (List.map (fun e -> Printf.sprintf "* **[%s](%s)**  *[(homepage](%s))*" e e (url_of_event e))
    (List.filter (fun e -> not (is_tutorial e)) events))) in
  write_file (basedir ^ "/Index") tmpl;
  (* event indexes *)
  List.iter (fun event ->
    let fname = Printf.sprintf "%s/%s/Index" basedir event in
    let articles =
      List.filter (fun i -> event_of_labels i i.T.issue_labels = event) !all_issues |> fun is ->
      String.concat ~sep:"\n" (List.map (fun i ->
        let time, title = parse_title i i.T.issue_title in
        Printf.sprintf "* %s: [%s](%s)" time title (title_dir title)) is)
    in
    let tmpl = Printf.sprintf
"---
title: %s
author: Gemma Gordon, Anil Madhavapeddy, Gabriel Scherer
abstract: Event is %s
---

%s
" event event articles in
    write_file fname tmpl
  ) (List.filter (fun e -> not (is_tutorial e)) events)

let get_user_repos =
  List.map (fun r ->
    match Stringext.split ~max:2 ~on:'/' r with
    | [user;repo] -> (user,repo)
    | _ -> eprintf "Repositories must be in username/repo format"; exit 1
  ) 

let print_issue token repos =
  (* Get the issues per repo *)
  get_user_repos repos |>
  Lwt_list.iter_s (fun (user,repo) ->
    Github.(Monad.(run (
      Issue.for_repo ~token ~user ~repo () |>
      Stream.to_list >|= 
      List.iter (generate_page user repo)
    )))
  ) >|=
  generate_indexes

let cmd =
  let cookie = Jar_cli.cookie () in
  let repos = Jar_cli.repos ~doc_append:" to list issues and PRs" () in
  let doc = "generate ICFP program" in
  let man = [
    `S "BUGS";
    `P "Email bug reports to <anil@recoil.rog>";
  ] in
  Term.((pure (fun t r ->
    Lwt_main.run (print_issue t r)
  ) $ cookie $ repos)),
  Term.info "git-list-issues" ~version:"1.0.0" ~doc ~man

let () = Fmt_tty.setup_std_outputs ()

let () = match Term.eval cmd with `Error _ -> exit 1 | _ -> exit 0

(*
 * Copyright (c) 2015 David Sheets <sheets@alum.mit.edu>
 * Copyright (c) 2015-2016 Anil Madhavapeddy <anil@recoil.org>
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 *)


