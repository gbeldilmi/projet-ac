Random.self_init ();;

let size = 12;;

type tile = {
  id: int;
  top: int;
  right: int;
  bottom: int;
  left: int;
} ;;

let rotate_tile_left t:tile =
  {
    id=t.id;
    right = t.top;
    top = t.right;
    bottom = t.left;
    left = t.bottom;
  };;

let rotate_tile_right t:tile =
  {
    id=t.id;
    top = t.left;
    bottom = t.right;
    left = t.top;
    right = t.bottom;
  };;
  
let rotate_tile_180 t:tile =
  {
    id=t.id;
    top = t.bottom;
    bottom = t.top;
    left = t.right;
    right = t.left;
  };; 

let create_random_tile () tile =
  {
    id=0;
    top = Random.int 11;
    bottom = Random.int 11;
    left = Random.int 11;
    right = Random.int 11;
  }  
;; 


let create_board size =
  Array.init size (fun _ ->
      Array.init size (fun _ ->
          { id=0; top=0; right=0; left=0; bottom=0 }
        )
    ) ;; 

let init_board size =
  let board = create_board size in
  let sizeMinus = size - 1 in
  for i = 0 to size - 1 do
    if i mod 2 = 0 then
      for j = 0 to size-1 do
        let current_tile = board.(i).(j) in
        board.(i).(j) <-
          {
            top = if i = 0 then 0 else board.(i-1).(j).bottom;
            bottom = if i = size-1 then 0 else Random.int 11 + 1;
            left = if j = 0 then 0 else board.(i).(j - 1).right;
            right = if j = size - 1 then 0 else Random.int 11 + 1;
            id = i*size+j; 
          };
      done
    else 
      for j = size-1 downto 0 do
        let current_tile = board.(i).(j) in
        board.(i).(j) <-
          {
            top = board.(i-1).(j).bottom;
            bottom = if i = size-1 then 0 else Random.int 11 + 1;
            left = if j = 0 then 0 else Random.int 11 + 1;
            right = if j = size - 1 then 0 else board.(i).(j + 1).left;
            id = i*size+j; 
          };
      done;
  done; 
  board;;

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

let b = init_board size;;

print_board b ();;







