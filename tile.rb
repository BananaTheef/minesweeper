class Tile
  attr_accessor :value

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

  def bombed?
  end

  def flagged?
  end

  def revealed?
  end

  def safe?
  end
end
