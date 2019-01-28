let ( >> ) f g x = g (f x)

let check_option = Alcotest.(check (option int))

let check_list = Alcotest.(check (list int))

let test_conversions_are_inverses () =
  let empty = [] in
  let not_empty = [1; 2; 3; 4] in
  let id = Zipper.from_list >> Zipper.to_list in
  check_list "conversions are inverses" empty (id empty) ;
  check_list "conversions are inverses" not_empty (id not_empty)


let test_to_list () =
  let l = [1; 2; 3] in
  let z = Zipper.from_list l in
  let z' = Zipper.next z in
  check_list "to list" l (Zipper.to_list z')


let test_prev_and_next () =
  let l = [3; 2; 1] in
  let z = Zipper.from_list l in
  let z' = Zipper.next z |> Zipper.prev in
  check_list "prev and next" (Zipper.to_list z) (Zipper.to_list z')


let test_peek () =
  let l = [1; 2; 3] in
  let z = Zipper.from_list l in
  check_option "peek" (Zipper.peek z) (Some 1) ;
  check_option "peek" (Zipper.next z |> Zipper.peek) (Some 2)


let test_pop () =
  let l = [1; 2; 3] in
  let z = Zipper.from_list l in
  check_list "pop" (Zipper.pop z |> Zipper.to_list) (List.tl l)


let test_put () =
  let x = 1 in
  let l = [2; 3] in
  let z = Zipper.from_list l in
  check_list "put" (Zipper.put x z |> Zipper.to_list) (x :: l)


let test_map () =
  let f = succ in
  let l = [1; 2; 3] in
  let z = Zipper.from_list l in
  check_list "map" (Zipper.map f z |> Zipper.to_list) (List.map f l)


let tests =
  [ ("conversions_are_inverses", `Quick, test_conversions_are_inverses)
  ; ("to_list", `Quick, test_to_list)
  ; ("test_prev_and_next_are_inverses", `Quick, test_prev_and_next)
  ; ("test_peek", `Quick, test_peek)
  ; ("test_pop", `Quick, test_pop)
  ; ("test_put", `Quick, test_put)
  ; ("test_map", `Quick, test_map) ]


let test_suites : unit Alcotest.test list = [("All", tests)]

let () = Alcotest.run "all" test_suites
