import random

class Tile:
  def __init__(self, id, top, right, bottom, left):
    self.id = id
    self.top = top
    self.right = right
    self.bottom = bottom
    self.left = left

class Eternity2:
  def __init__(self, colors, size):
    self.colors = colors
    self.size = size
    self.board = [[None for _ in range(size)] for _ in range(size)]
    self.tiles = []
  def __str__(self):
    s = "+"
    for j in range(self.size):
      s += "----------+" * self.size + "\n|"
      for i in range(self.size):
        s += "    {:02d}    |".format(self.board[i][j].top) if self.board[i][j] is not None else "    <>    |"
      s += "\n|"
      for i in range(self.size):
        s += "{:02d} {:04d} {:02d}|".format(self.board[i][j].left, self.board[i][j].id, self.board[i][j].right) if self.board[i][j] is not None else "<> <<>> <>|"
      s += "\n|"
      for i in range(self.size):
        s += "    {:02d}    |".format(self.board[i][j].bottom) if self.board[i][j] is not None else "    <>    |"
      s += "\n+"
    s += "----------+" * self.size + "\n"
    return s
  def save_to_file(self, filename):
    with open(filename, "w") as f:
      f.write(str(self))
  def init_grid(self):
    nt = 0
    for j in range(self.size):
      for i in range(self.size):
        self.board[i][j] = Tile(nt,
          random.randint(0, self.colors - 1) if j == 0             else self.board[i][j - 1].bottom,
          random.randint(0, self.colors - 1) if i != self.size - 1 else self.board[0][j].left,
          random.randint(0, self.colors - 1) if j != self.size - 1 else self.board[i][0].top,
          random.randint(0, self.colors - 1) if i == 0             else self.board[i - 1][j].right)
        nt += 1
  def shuffle(self):
    assert self.board[0][0] is not None
    assert self.tiles == []
    for i in range(self.size):
      for j in range(self.size):
        self.tiles.append(self.board[i][j])
        self.board[i][j] = None
    assert len(self.tiles) == self.size * self.size
    random.shuffle(self.tiles)
  def solve(self):
    def solve_backtrack(i, j):
      def test_tile(t, i, j):
        ######################################################################################################
        def neighbor(c, d):
          return (c + d + self.size - 1) % self.size
        def check_top(t, i, j):
          n = self.board[i][neighbor(j, -1)]
          return self.tiles[t].top == n.bottom if n is not None else True
        def check_right(t, i, j):
          n = self.board[neighbor(i, 1)][j]
          return self.tiles[t].right == n.left if n is not None else True
        def check_bottom(t, i, j):
          n = self.board[i][neighbor(j, 1)]
          return self.tiles[t].bottom == n.top if n is not None else True
        def check_left(t, i, j):
          n = self.board[neighbor(i, -1)][j]
          return self.tiles[t].left == n.right if n is not None else True
        if self.tiles[t].id == j * self.size + i: ############################################################
          return True                             ############################################################
        #if check_left(t, i, j):
        #  if check_top(t, i, j):
        #    if check_right(t, i, j):
        #      if check_bottom(t, i, j):
        #        return True
        return False
        ######################################################################################################
      if self.board[i][j] is None:
        t = 0
        while t in range(len(self.tiles)):
          if self.tiles[t] is not None:
            print("solve_backtrack({}, {}): trying tile {}".format(i, j, t)) #################################
            if test_tile(t, i, j):
              self.board[i][j] = self.tiles[t]
              self.tiles[t] = None
              if i < self.size - 1:
                if solve_backtrack(i + 1, j):
                  return True
              elif j < self.size - 1:
                if solve_backtrack(0, j + 1):
                  return True
              else:
                return True
              self.tiles[t] = self.board[i][j]
              self.board[i][j] = None
          t += 1
      else:
        if i < self.size - 1:
          solve_backtrack(i + 1, j)
        elif j < self.size - 1:
          solve_backtrack(0, j + 1)
        else:
          return
    solve_backtrack(0, 0)

if __name__ == "__main__":
  e2 = Eternity2(3, 3) #(12, 16)
  e2.init_grid()
  print(e2)
  e2.save_to_file("e2a.txt")
  e2.shuffle()
  print(e2)
  e2.save_to_file("e2b.txt")
  e2.solve()
  print(e2)
  e2.save_to_file("e2c.txt")
