class Game
  def initialize
    @board = Board.new(n, bombs_count)
  end

  def prompt
    puts "Choose a position to be revealed or flagged(e.g.: '1,3'):"
    puts ">"
  end

  def get_pos
  end

  def reveal
  end

  def flag
  end

  def run
  end

  def game_over?
  end
end
