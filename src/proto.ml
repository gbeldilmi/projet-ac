Random.self_init ();;

type edge =  
  | Top
  | Bottom
  | Left
  | Right;;

type color = 
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
  | Top
  | Bottom
  | Left
  | Right 
  | Black 
;; 


type piece = { 
  id: int;
  top: color;   
  bottom: color;
  left: color;
  right: color;
}

type neighbor = E of edge | P of piece;; 

type board = {
  piece: piece;
  top: neighbor;
  bottom: neighbor;
  left: neighbor;
  right: neighbor;
}

let rotate_piece_left p:piece =
  {
    id = p.id; 
    top = p.right; 
    bottom = p.left; 
    left = p.bottom; 
    right = p.top;
  };;
  
let rotate_piece_right p:piece =
  {
    id = p.id; 
    top = p.left; 
    bottom = p.right; 
    left = p.top; 
    right = p.bottom;
  };;
  
let rotate_piece_180 p:piece = 
  {
    id = p.id; 
    top = p.bottom; 
    bottom = p.top; 
    left = p.right; 
    right = p.left;
  };;

let random_color () =
  match Random.int 15 with
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
  | 10 -> Top
  | 11 -> Bottom
  | 12 -> Left
  | 13 -> Right
  | _ -> Black

let create_random_piece (id) = 
  {
    id = id; 
    top = random_color(); 
    bottom = random_color(); 
    left = random_color(); 
    right = random_color();
  }  
;;

let create_random_board (size) = 0 ;;










