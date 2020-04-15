require 'yaml'
require_relative 'board.rb'

class Game
  attr_reader :board

  LAYOUT = { e: [ 9, 10 ],
             m: [ 16, 40 ],
             h: [ 20, 85 ] }

  def initialize(difficulty=:e)
    @board = Board.new(LAYOUT[difficulty].first, LAYOUT[difficulty].last)
    @saved = false
  end

  def valid_pos?(pos)
    return false unless pos.is_a? Array
    return false unless pos.length == 2
    return false unless pos.all? { |i| (0..9).include?(i) }
    true
  end

  def invalid_action(action)
    puts "Sry, '#{action}' is not a valid action."
  end

  def prompt
    puts "Choose a position(e.g.: '1,3'):"
    print "> "
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
    puts "Do you want to (r)eaveal, (f)lag or (s)ave the game?"
    print "> "
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

  def file_empty?
    File.empty?("save.rb")
  end

  def open_saved_file(mode)
    File.open("save.rb", mode)
  end

  def delete_saved_file
    File.open("save.rb", "w").truncate(0)
  end

  def save
    saved_game = self.open_saved_file("w")
    saved_game.write(@board.to_yaml)
    @saved = true
  end

  def saved?
    @saved
  end

  def load
    saved_game = self.open_saved_file("r")
    @board = YAML::load(saved_game)
  end

  def take_action(action)
    case action
    when "r", "f"
      pos = self.get_pos
      action == "r" ? self.scout(pos) : self.flag(pos)
    when "s"
      self.save
    else
      self.invalid_action(action)
    end
  end

  def best_wishes
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
    self.best_wishes
    until self.game_over? || self.saved?
      @board.render
      action = self.get_action
      self.take_action(action)
    end
    @board.won? ? self.won : self.lost
    @board.reveal
    self.delete_saved_file unless self.file_empty?
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Welcome to a game of Minesweeper."

  unless File.empty?("save.rb")
    puts "Do you want to load a saved game?(y/n)"
    load_game = gets.chomp
  end

  if load_game == "y"
    game = Game.new
    game.load
  else
    puts "What difficulty do you choose: (e)asy, (m)edium or (h)ard?"
    print "> "
    difficulty = gets.chomp.to_sym
    game = Game.new(difficulty)
  end

  game.run
end
