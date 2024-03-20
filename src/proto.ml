type tile = {
  id: int;
  top: int;
  right: int;
  bottom: int;
  left: int;
}

type board = tile array array

let create_tile id top right bottom left =  { id; top; right; bottom; left }

let create_board size =
  Array.make_matrix size size (create_tile 0 0 0 0 0)

let print_board board =
  Array.iter (fun row ->
    Array.iter (fun tile ->
      Printf.printf "+----------";
    ) row;
    Printf.printf "+\n";
    Array.iter (fun tile ->
      Printf.printf "|    %d    " tile.top;
    ) row;
    Printf.printf "|\n";
    Array.iter (fun tile ->
      Printf.printf "|%d   %d   %d" tile.left tile.id tile.right;
    ) row;
    Printf.printf "|\n";
    Array.iter (fun tile ->
      Printf.printf "|    %d    " tile.bottom;
    ) row;
    Printf.printf "|\n";
  ) board;
  Printf.printf "+";
  Array.iter (fun _ ->
    Printf.printf "----------+";
  ) board;

let board = create_board 3 in
print_board board;

