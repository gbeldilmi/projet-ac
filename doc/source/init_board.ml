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
  
(* Création de gauche à droite puis droite à gauche une ligne sur deux pour simuler le parcours optimal non fait pour le backtrack *)
