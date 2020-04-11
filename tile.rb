class Tile
  def initialize(value, board, revealed=false, flagged=false)
    @value = value
    @board = board
    @flagged = flagged
    @revealed = revealed
  end

  def inspect
    "#<Tile:#{object_id} @value=#{@value}, @flag=#{@flag}, @revealed=#{@revealed}>"
  end

  def reveal
    @revealed = true
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
