class Board
  def initialize(n=9, bombs_count=10)
    @grid = Array.new(n) { Array.new(n) }
    @bombs_count = bombs_count
  end

  def place_bombs

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
