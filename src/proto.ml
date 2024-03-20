type tile = {
  id: int;
  top: int;
  right: int;
  bottom: int;
  left: int;
}

type board = tile array array

let create_tile id top right bottom left =
  { id; top; right; bottom; left };

let create_board width height =
  Array.make_matrix width height (create_tile 0 0 0 0 0)

let print_board board =
  Printf.printf "+";
  Array.iter (fun row ->
    Array.iter (fun tile ->
      Printf.printf "----------+";
    ) row;
    Printf.printf "\n|";
    Array.iter (fun tile ->
      Printf.printf "    %d    |" tile.top;
    ) row;
    Printf.printf "\n|";
    Array.iter (fun tile ->
      Printf.printf "%d   %d   %d|" tile.left tile.id tile.right;
    ) row;
    Printf.printf "\n|";
    Array.iter (fun tile ->
      Printf.printf "    %d    |" tile.bottom;
    ) row;
    Printf.printf "\n";
  ) board;
  Printf.printf "+";
  Array.iter (fun _ ->
    Printf.printf "----------+";
  ) board.(0);

let main () =
  let size = 3 in
  let board = create_board size in
  print_board board;

let () = main ()
