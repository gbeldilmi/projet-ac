Random.self_init ();;

let board_size = 12;;

type edge =  
  | Top
  | Bottom
  | Left
  | Right;;

type color = (*peu remplacer par des nombres si nécéssaires*)
  | White
  | Red
  | Green
  | Yellow
  | Blue
  | Pink
  | Gray
  | Brown
  | Orange
  | Purple
  | Black
;;


type piece = {
  top: color;  
  bottom: color;
  left: color;
  right: color;
} 

let rotate_piece_left p:piece =
  {
    top = p.right;
    bottom = p.left;
    left = p.bottom;
    right = p.top;
  };;

let rotate_piece_right p:piece =
  {
    top = p.left;
    bottom = p.right;
    left = p.top;
    right = p.bottom;
  };;
  
let rotate_piece_180 p:piece =
  {
    top = p.bottom;
    bottom = p.top;
    left = p.right;
    right = p.left;
  };;

let random_color () =
  match Random.int 11 with
  | 0 -> White
  | 1 -> Red
  | 2 -> Green
  | 3 -> Yellow
  | 4 -> Blue
  | 5 -> Pink
  | 6 -> Gray
  | 7 -> Brown
  | 8 -> Orange
  | 9 -> Purple
  | _ -> Black

let create_random_piece () =
  {
    top = random_color();
    bottom = random_color();
    left = random_color();
    right = random_color();
  }  
;;

let create_board n =
  let rec row = function
    | 0 -> []
    | m -> create_random_piece() :: row (m - 1)
  in
  let rec board = function
    | 0 -> []
    | m -> row n :: board (m - 1)
  in
  board n
  
let game_board = create_board board_size;;  

let print_board board =
  let print_color = function
    | White -> print_string "W "
    | Red -> print_string "R "
    | Green -> print_string "G "
    | Yellow -> print_string "Y "
    | Blue -> print_string "B "
    | Pink -> print_string "P "
    | Gray -> print_string "Gr"
    | Brown -> print_string "Br"
    | Orange -> print_string "O "
    | Purple -> print_string "Pu"
    | Black -> print_string "Bl"
  in
  let print_piece_row row =
    List.iter (fun piece ->
        print_color piece.top;
        print_string "  ";
        print_color piece.left;
        print_string "  ";
        print_color piece.right; 
        print_string "  ";
        print_color piece.bottom;
        print_string" - ") row;
    print_endline ""
  in
  List.iter print_piece_row board;; 

print_board game_board;;


