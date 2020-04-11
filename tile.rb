class Tile
  attr_accessor :value

  def initialize(board, pos, value=" _ ", revealed=false, flagged=false)
    @board = board
    @pos = pos
    @value = value
    @flagged = flagged
    @revealed = revealed
  end

  def to_s
    if self.revealed?
      self.value
    elsif self.flagged?
      "|F|"
    else
      "|_|"
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

  def reveal
    @revealed = !@revealed
  end

  def flag
    @flagged = !@flagged
  end

  def bombed?
    self.value == "*" ? true : false
  end

  def flagged?
    @flagged
  end

  def revealed?
    @revealed
  end

  def safe?
    self.value == "_" ? true : false
  end
end
