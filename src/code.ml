Random.self_init ();;

let size = 12 ;;
let nbColor = 10 ;;

type tile = {
  id: int;
  top: int;
  right: int;
  bottom: int;
  left: int;
  flag: bool;
} ;;

let create_board size =
  Array.init size (fun _ ->
      Array.init size (fun _ ->
          { id=(-1); top=0; right=0; left=0; bottom=0; flag=true}
        )
    ) ;; 

let init_board size =
  let board = create_board size in
  for i = 0 to size - 1 do
    if i mod 2 = 0 then
      for j = 0 to size-1 do
        board.(i).(j) <-
          {
            top = if i = 0 then 0 else board.(i-1).(j).bottom;
            bottom = if i = size-1 then 0 else Random.int nbColor + 1;
            left = if j = 0 then 0 else board.(i).(j - 1).right;
            right = if j = size - 1 then 0 else Random.int nbColor + 1;
            id = i*size+j; 
            flag=true;
          };
      done
    else 
      for j = size-1 downto 0 do
        board.(i).(j) <-
          {
            top = board.(i-1).(j).bottom;
            bottom = if i = size-1 then 0 else Random.int nbColor + 1;
            left = if j = 0 then 0 else Random.int nbColor + 1;
            right = if j = size - 1 then 0 else board.(i).(j + 1).left;
            id = i*size+j; 
            flag=true;
          };
      done;
  done; 
  board;;

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


let shuffle_board board =
  for i = 0 to size - 1 do
    for j = 0 to size - 1 do
      let random_i = Random.int size in
      let random_j = Random.int size in
      let temp_tile = board.(i).(j) in
      board.(i).(j) <- board.(random_i).(random_j);
      board.(random_i).(random_j) <- temp_tile;
    done;
  done;
  board ;;

let init_tiles board=
  let tiles = Array.make (size*size) ({ id=(-1); top=0; right=0; left=0; bottom=0; flag=true}) in
  for i = 0 to size - 1 do
    for j = 0 to size - 1 do
      tiles.((i)*size+j) <- board.(i).(j);
    done;
  done;
  tiles ;; 

let rec solve_backtrack board tiles i j =
  
  let test_tile t i j =
    let res = ref true in
    if j != 0 && board.(i).(j - 1).right != tiles.(t).left then
      res := false
    else if j != 0 && tiles.(t).left = 0 then
      res := false
    else if j != (size - 1) && tiles.(t).right = 0 then
      res := false
    else if i != 0 && board.(i - 1).(j).bottom != tiles.(t).top then
      res := false
    else if i != 0 && tiles.(t).top = 0 then
      res := false
    else if i != (size - 1) && tiles.(t).bottom = 0 then
      res := false
    else if i = 0 && (tiles.(t).top != 0) then
      res := false
    else if i = (size - 1) && (tiles.(t).bottom != 0) then
      res := false
    else if j = 0 && (tiles.(t).left != 0) then
      res := false
    else if j = (size - 1) && (tiles.(t).right != 0) then
      res := false;
    !res; 
  in 
  
  if board.(i).(j).id = -1 then
    for t = 0 to (Array.length tiles) -1 do
      if tiles.(t).id != -1 then
        if test_tile t i j then begin
          board.(i).(j) <- tiles.(t);
          tiles.(t) <- { id = -1; top = 0; right = 0; bottom = 0; left = 0; flag=true };
          if i < size - 1 then 
            solve_backtrack board tiles (i+1) j
          else if j < size - 1 then
            solve_backtrack board tiles 0 (j+1)
          else 
            print_board board;
          tiles.(t) <- board.(i).(j);
          board.(i).(j) <- { id = -1; top = 0; right = 0; bottom = 0; left = 0; flag=true }; 
        end
    done 
  else if i < size - 1 then 
    solve_backtrack board tiles (i+1) j
  else if j < size - 1 then
    solve_backtrack board tiles 0 (j+1)
  else 
    print_board board;
;;


(* main *)

let b = init_board size ;;
Printf.printf "Initial board\n" ;;
print_board b ;;

Printf.printf "\n\nShuffled board\n" ;;
let b = shuffle_board b ;;
print_board b ;;

Printf.printf "\n\nSolving: may the time be with you\n";;
let tiles = init_tiles b;;
let board = create_board size;;
solve_backtrack board tiles 0 0; 
Printf.printf "\n\nSolving: end of time\n" ;

