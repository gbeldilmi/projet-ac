let rec solve_backtrack board tiles i j = (* i et j représentent la position du board que l'on va tester *)
  if board.(i).(j).id = -1 then (* Vérification qu'aucune pièce n'es déja placé *)
    for t = 0 to (Array.length tiles) -1 do
      if tiles.(t).id != -1 then (* Vérification que la pièce est valide *)
        if test_tile t i j then begin (* Test de compatibilité de la pièce *)
          (* Placement de la pièce et retrait de la liste des pièces disponibles *)
          board.(i).(j) <- tiles.(t); 
          tiles.(t) <- { id = -1; top = 0; right = 0; bottom = 0; left = 0; flag=true };
          (* backtrack *)
          if j < size - 1 then 
            solve_backtrack board tiles i (j+1)
          else if i < size - 1 then
            solve_backtrack board tiles (i+1) 0
          else 
            print_board board;
          (* On retire la pièce et ajout dans la liste des 
          pièce disponible pour chercher les prochaines solutions *)
          tiles.(t) <- board.(i).(j); 
          board.(i).(j) <- { id = -1; top = 0; right = 0; bottom = 0; left = 0; flag=true }; 
        end
    done 
  (* failsafe pour le backtrack *)
  else if j < size - 1 then 
    solve_backtrack board tiles i (j+1)
  else if i < size - 1 then
    solve_backtrack board tiles (i+1) 0
  else 
    print_board board;
;;
