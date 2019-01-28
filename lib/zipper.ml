type 'a zipper = 'a list * 'a list

let from_list from = ([], from)

let to_list (left, right) = List.rev left @ right

let prev = function ([], _) as x -> x | h :: t, right -> (t, h :: right)

let next = function (_, []) as x -> x | left, h :: t -> (h :: left, t)

let peek = function _, [] -> None | _, left :: _ -> Some left

let pop = function (_, []) as x -> x | left, _ :: t -> (left, t)

let put x (left, right) = (left, x :: right)

let map f (left, right) =
  let map = List.map f in
  (map left, map right)
