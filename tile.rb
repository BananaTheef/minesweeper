class Tile
  def initialize(value, board, revealed, flagged=false)
    @value = value
    @board = board
    @flag = flagged
    @revealed = revealed
  end

  def inspect
    "#<Tile:#{object_id} @value=#{@value}, @flag=#{@flag}"
  end

  def reveal

  end

  def neighbours
  end

  def neighbour_bomb_count
  end

  def bombed?
  end

  def flagged?
  end

  def revealed?
  end

  def safe?
  end
end
