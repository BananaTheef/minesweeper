require_relative 'constants.rb'
require_relative 'tile.rb'

class Board
  def initialize(n=9, bombs_count=10)
    @grid = Array.new(n) { Array.new(n) }
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

  def size
    @grid.length
  end

  def place_bombs
    count = 0
    until count == @bombs_count
      pos = [rand(self.size), rand(self.size)]
      if self[pos].nil?
        self[pos] = Tile.new(pos, BOMB)
        count += 1
      end
    end
  end

  def populate
    (0...self.size).each do |row|
      (0...self.size).each do |col|
        pos = row, col
        self[pos] = Tile.new(pos, FREE, @grid) if self[pos].nil?
      end
    end
  end

  def render
    puts "   #{(0...self.size).to_a.join('  ')}"
    @grid.each_with_index do |row, i|
      puts "#{i} #{row.join('')}"
    end
    nil
  end

  def reveal(pos)
    self[pos].reveal
  end

  def flag(pos)
    self[pos].flag
  end

  def won?
    @grid.all? do |row|
      row.all? { |tile| tile.revealed? && tile.safe? }
    end
  end
end
