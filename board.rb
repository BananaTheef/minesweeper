require_relative 'tile.rb'

class Board
  def initialize(n=9, bombs_count=10)
    @grid = Array.new(n) { Array.new(n) { Tile.new("|_|") } }
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
      if self[pos].value == "_"
        self[pos].value = "*"
        count += 1
      end
    end
  end

  def size
    @grid.length
  end

  def render
    puts "   #{(0...self.size).to_a.join('   ')}"
    @grid.each_with_index do |row, i|
      puts "#{i} #{row.join(' ')}"
    end
    nil
  end

  def reveal(pos)
    self[pos].reveal
  end

  def flag
    self[pos].flag
  end

  def won?
    @grid.all? do |row|
      row.all? { |tile| tile.revealed? && tile.safe? }
    end
  end
end
