require 'byebug'
require_relative 'board.rb'

class Game
  def initialize(n=9, bombs_count=10)
    @board = Board.new(n, bombs_count)
    @board_size = n
  end

  def valid_pos?(pos)
    # debugger
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
