require_relative 'board.rb'

class Game
  attr_reader :board

  LAYOUT = { e: [ 9, 10 ],
             m: [ 16, 40 ],
             h: [ 20, 85 ] }

  def initialize(difficulty)
    @board = Board.new(LAYOUT[difficulty].first, LAYOUT[difficulty].last)
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

  def get_action
    puts "Do you want to (r)eaveal or (f)lag the position?"
    gets.chomp
  end

  def parse_int(string)
    string.split(",").map { |c| Integer(c) }
  end

  def scout(pos)
    @board[pos].scout
  end

  def flag(pos)
    @board[pos].flag
  end

  def start
    puts "Enjoy the game and good luck."
  end

  def won
    puts "Congratulation, you won!"
  end

  def lost
    puts "You lost!"
  end

  def game_over?
    @board.won? || @board.lost?
  end

  def run
    self.start
    until self.game_over?
      @board.render
      pos = self.get_pos
      action = self.get_action
      action == "r" ? self.scout(pos) : self.flag(pos)
    end
    @board.won? ? self.won : self.lost
    @board.reveal
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Welcome to a game of Minesweeper."
  puts "What difficulty do you choose: (e)asy, (m)edium or (h)ard?"
  difficulty = gets.chomp.to_sym
  game = Game.new(difficulty)
  game.run
end
