class Board
  def initialize(n=9, bombs_count=10)
    @grid = Array.new(n) { Array.new(n, "_") }
    @bombs_count = bombs_count
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, val)
    row, col = pos
    @grid[row][col] = val
  end

  def place_bombs
    count = 0
    until count == @bombs_count
      pos = [rand(self.size), rand(self.size)]
      if self[pos] == "_"
        self[pos] = "*"
        count += 1
      end
    end
  end

  def size
    @grid.length
  end

  def render
  end

  def reveal
  end

  def flag
  end

  def won?
  end
end
