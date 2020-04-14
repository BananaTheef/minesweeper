require_relative 'tile.rb'

class Board
  attr_reader :grid_size, :bombs_count

  def initialize(grid_size=9, bombs_count=10)
    @grid_size = grid_size
    @bombs_count = bombs_count
    self.populate
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end


  def render
    puts "   #{(0...@grid_size).to_a.join('  ')}"
    @grid.each_with_index do |row, i|
      puts "#{i} #{row.join('')}"
    end
    nil
  end

  def reveal
    @grid.each do |row|
      row.each { |tile| tile.reveal }
    end
    self.render
  end

  def place_bombs
    count = 0
    until count == @bombs_count
      pos = [rand(@grid_size), rand(@grid_size)]
      tile = self[pos]
      unless tile.bombed?
        tile.bomb
        count += 1
      end
    end
  end

  def populate
    @grid = Array.new(grid_size) do |row|
      Array.new(grid_size) { |col| Tile.new(self, [row, col]) }
    end
    self.place_bombs
  end

  def lost?
    @grid.flatten.any? { |tile| tile.bombed? && tile.revealed? }
  end

  def won?
    @grid.flatten.all? { |tile| tile.bombed? != tile.revealed? }
  end
end
