let test_tile t i j =
	let res = ref true in
	
	(* Piece à gauche existante *)
	if j != 0 && board.(i).(j - 1).right != tiles.(t).left then
	  res := false
	(* Bordure gauche impossible en intérieur *)  
	else if j != 0 && tiles.(t).left = 0 then
	  res := false
	(* Bordure droite impossible en intérieur *)  
	else if j != (size - 1) && tiles.(t).right = 0 then
	  res := false
	(* Bordure gauche *)  
	else if j = 0 && (tiles.(t).left != 0) then
	  res := false 
	(* Bordure droite *)  
	else if j = (size - 1) && (tiles.(t).right != 0) then
	  res := false
	  
	(* Piece supérieur existante *)  
	else if i != 0 && board.(i - 1).(j).bottom != tiles.(t).top then
	  res := false
	(* Bordure supérieur impossible en intérieur *)  
	else if i != 0 && tiles.(t).top = 0 then
	  res := false
	(* Bordure inférieur impossible en intérieur *)   
	else if i != (size - 1) && tiles.(t).bottom = 0 then
	  res := false
	(* Bordure supérieur *)  
	else if i = 0 && (tiles.(t).top != 0) then
	  res := false
	(* Bordure inférieur *)   
	else if i = (size - 1) && (tiles.(t).bottom != 0) then
	  res := false;
	  
	(* Parcours de droite à gauche, de haut en bas donc non nécéssaire 
	de vérifier les pièces en dessous et à droite
	mais nécéssaire de vérifier les bordures *)
	  
	!res; 
	in 
  
 
