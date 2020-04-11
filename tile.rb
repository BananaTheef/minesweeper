require_relative 'constants.rb'

class Tile
  attr_accessor :value

  def initialize(pos, value, board=[], revealed=false, flagged=false)
    @board = board
    @pos = pos
    @value = value
    @flagged = flagged
    @revealed = revealed
  end

  def [](pos)
    row, col = pos
    @board[row][col]
  end

  def to_s
    if self.revealed?
      self.value
    elsif self.flagged?
      " F "
    else
      " * "
    end
  end

  def neighbours
    top = [@pos.first - 1, @pos.last]
    top_right = [@pos.first - 1, @pos.last + 1]
    right = [@pos.first, @pos.last + 1]
    bottom_right = [@pos.first + 1, @pos.last + 1]
    bottom = [@pos.first + 1, @pos.last]
    bottom_left = [@pos.first + 1, @pos.last - 1]
    left = [@pos.first, @pos.last - 1]
    top_left = [@pos.first - 1, @pos.last - 1]
    [top, top_right, right, bottom_right, bottom, bottom_left, left, top_left]
      .select { |pos| pos.none? { |i| i < 0 } }
  end

  def neighbours_bomb_count
    self.neighbours.count { |pos| self[pos].value == BOMB }
  end

  def reveal
    @revealed = !@revealed
  end

  def flag
    @flagged = !@flagged
  end

  def bombed?
    self.value == BOMB ? true : false
  end

  def flagged?
    @flagged
  end

  def revealed?
    @revealed
  end

  def safe?
    self.value == FREE ? true : false
  end
end
