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
