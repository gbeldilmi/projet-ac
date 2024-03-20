import random, sys

sys.setrecursionlimit(1000000)

class Tile:
    def __init__(self, id, top, right, bottom, left):
        self.id = id
        self.top = top
        self.right = right
        self.bottom = bottom
        self.left = left

class Beautify:
    def __init__(self, size):
        self.size = size
        self.board = [[None for _ in range(size)] for _ in range(size)]

    def main(self):  
        contenu = ""
        with open('msg.txt', 'r') as fichier:
            contenu = fichier.read()
        for i in range(0, len(contenu), 9):
            T = Tile(i//9, contenu[i:i+2], contenu[i+2:i+4], contenu[i+4:i+6], contenu[i+6:i+8])
            col = (i // (9*self.size))%self.size
            if col < len(self.board):
                row=(i//9)%self.size
                if row < len(self.board):
                    if i//9<self.size*self.size:
                        self.board[row][col] = T
                        print(i//9)
        print(str(self))
        
    def __str__(self):
        s = "+"
        for j in range(self.size):
            s += "----------+" * self.size + "\n|"
            for i in range(self.size):
                s += "    {:02s}    |".format(self.board[i][j].top) if self.board[i][j] is not None else "    <>    |"
            s += "\n|"
            for i in range(self.size):
                s += "{:02s} {:04d} {:02s}|".format(self.board[i][j].left, self.board[i][j].id, self.board[i][j].right) if self.board[i][j] is not None else "<> <<>> <>|"
            s += "\n|"
            for i in range(self.size):
                s += "    {:02s}    |".format(self.board[i][j].bottom) if self.board[i][j] is not None else "    <>    |"
            s += "\n+"
        s += "----------+" * self.size + "\n"
        return s
        
if __name__ == '__main__':
    Beautify = Beautify(12)
    Beautify.main()
