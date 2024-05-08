let print_board = fun board ->
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
  Printf.printf "\n" ;;
