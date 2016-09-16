(* Comment on the blog issues about where the live URL for talk is *)

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
 
let add_comment token user repo issue =
  let open Github.Monad in
  all_issues := issue :: !all_issues;
  let issue_labels = issue.T.issue_labels in
  let event = event_of_labels issue issue_labels in
  if not (is_tutorial event) then begin
  let time,title = parse_title issue issue.T.issue_title in
  let tdir = title_dir title in
  let body = Printf.sprintf "The liveblog for this talk is at <http://icfp2016.mirage.io/%s/%s.md>. The file to edit is <https://github.com/ocamllabs/icfp2016-blog/blob/master/%s/%s.md>\n" event tdir event tdir in
  Github.Issue.create_comment ~token ~user ~repo ~num:issue.T.issue_number ~body () >>= fun _ ->
  return ()
  end else return ()

let get_user_repos =
  List.map (fun r ->
    match Stringext.split ~max:2 ~on:'/' r with
    | [user;repo] -> (user,repo)
    | _ -> eprintf "Repositories must be in username/repo format"; exit 1
  ) 

let comment_issue token repos =
  (* Get the issues per repo *)
  get_user_repos repos |>
  Lwt_list.iter_s (fun (user,repo) ->
    Github.(Monad.(run (
      Issue.for_repo ~token ~user ~repo () |>
      Stream.iter (add_comment token user repo)
    )))
  )

let cmd =
  let cookie = Jar_cli.cookie () in
  let repos = Jar_cli.repos ~doc_append:" to list issues and PRs" () in
  let doc = "comment on issues with live urls" in
  let man = [
    `S "BUGS";
    `P "Email bug reports to <anil@recoil.rog>";
  ] in
  Term.((pure (fun t r ->
    Lwt_main.run (comment_issue t r)
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


