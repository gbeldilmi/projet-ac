import random, sys

sys.setrecursionlimit(1000000)

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
    print("init_grid: grid created\n" + str(self))
  def shuffle(self):
    assert self.board[0][0] is not None
    assert self.tiles == []
    for i in range(self.size):
      for j in range(self.size):
        self.tiles.append(self.board[i][j])
        self.board[i][j] = None
    assert len(self.tiles) == self.size * self.size
    random.shuffle(self.tiles)
    print("shuffle: grid shuffled\n" + str(self))
  def solve(self):
    def solve_backtrack(i, j):
      def test_tile(t, i, j):
        if j != 0:
          if self.tiles[t].top != self.board[i][j - 1].bottom:
            return False
        if i == self.size - 1:
          if self.tiles[t].right != self.board[0][j].left:
            return False
        if j == self.size - 1:
          if self.tiles[t].bottom != self.board[i][0].top:
            return False
        if i != 0:
          if self.tiles[t].left != self.board[i - 1][j].right:
            return False
        return True
      if self.board[i][j] is None:
        t = 0
        while t in range(len(self.tiles)):
          if self.tiles[t] is not None:
            if test_tile(t, i, j):
              self.board[i][j] = self.tiles[t]
              self.tiles[t] = None
              if i < self.size - 1:
                solve_backtrack(i + 1, j)
              elif j < self.size - 1:
                solve_backtrack(0, j + 1)
              else:
                print("solve_backtrack: found solution\n" + str(self))
              self.tiles[t] = self.board[i][j]
              self.board[i][j] = None
          t += 1
      else:
        if i < self.size - 1:
          solve_backtrack(i + 1, j)
        elif j < self.size - 1:
          solve_backtrack(0, j + 1)
        else:
          print("solve_backtrack: found solution\n" + str(self))
      return
    print("solve: may the time be with you")
    solve_backtrack(0, 0)
    print("solve: end of time")

if __name__ == "__main__":
  e2 = Eternity2(10, 12)
  e2.init_grid()
  e2.shuffle()
  e2.solve()
