if k=0 then 
        board.(i).(j) <- tiles.(t)
      else if k = 1 then 
        board.(i).(j) <- rotate_tile_left tiles.(t)
      else if k = 2 then
        board.(i).(j) <- rotate_tile_180 tiles.(t)
      else
        board.(i).(j) <- rotate_tile_right tiles.(t);
