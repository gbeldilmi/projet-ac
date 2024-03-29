type tile = {
  id: int;
  top: int;
  right: int;
  bottom: int;
  left: int;
} ;;

let create_board size =
  Array.init size (fun _ ->
    Array.init size (fun _ ->
      { id=0; top=0; right=0; left=0; bottom=0 }
    )
  ) ;;

let print_board board = fun () ->
  Array.iter (fun row ->
    Array.iter (fun tile ->
      Printf.printf "+--------------";
    ) row;
    Printf.printf "+\n";
    Array.iter (fun tile ->
      Printf.printf "|      %02d      " tile.top;
    ) row;
    Printf.printf "|\n";
    Array.iter (fun tile ->
      Printf.printf "|%02d   %04d   %02d" tile.left tile.id tile.right;
    ) row;
    Printf.printf "|\n";
    Array.iter (fun tile ->
      Printf.printf "|      %02d      " tile.bottom;
    ) row;
    Printf.printf "|\n";
  ) board;
  Printf.printf "+";
  Array.iter (fun _ ->
    Printf.printf "--------------+";
  ) board;
  Printf.printf "\n"; ;;

let b = create_board 5;;
print_board b ();;


