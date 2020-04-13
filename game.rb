require_relative 'board.rb'

class Game
  def initialize(n=9, bombs_count=10)
    @board = Board.new(n, bombs_count)
    @board_size = n
  end

  def valid_pos?(pos)
    return false unless pos.is_a? Array
    return false unless pos.length == 2
    return false unless pos.all? { |i| (0..9).include?(i) }
    true
  end

  def prompt
    puts "Choose a position to be revealed or flagged(e.g.: '1,3'):"
    puts ">"
  end

  def get_pos
    pos = nil
    self.prompt
    until self.valid_pos?(pos)
      begin
        pos = parse_int(gets.chomp)
      rescue
        puts "Use digits 0-9."
      end
    end
    pos
  end

  def parse_int(string)
    string.split(",").map { |c| Integer(c) }
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
