require 'colorize'

class Tile
  attr_accessor :pos

  def initialize(board, pos)
    @board = board
    @board_size = @board.grid_size-1
    @pos = pos
    @flagged = false
    @revealed = false
    @bombed = false
  end

  def inspect
    { 'pos' => @pos,
      'flagged' => self.flagged?,
      'revealed' => self.revealed?,
      'fringed' => self.fringed? }.inspect
  end

  def to_s
    if self.flagged?
      " F "
    elsif self.bombed? && self.revealed?
      " B ".colorize(:black)
    elsif self.revealed?
      self.any_neighbors_bomb? ? self.bomb_count_colorized : " _ "
    else
      " * "
    end
  end

  def bomb_count_colorized
    case bomb_count = self.neighbors_bomb_count
    when 1
    " #{bomb_count} ".colorize(:blue)
    when 2
    " #{bomb_count} ".colorize(:green)
    else
    " #{bomb_count} ".colorize(:red)
    end
  end

  def neighbors
    top = [@pos.first - 1, @pos.last]
    top_right = [@pos.first - 1, @pos.last + 1]
    right = [@pos.first, @pos.last + 1]
    bottom_right = [@pos.first + 1, @pos.last + 1]
    bottom = [@pos.first + 1, @pos.last]
    bottom_left = [@pos.first + 1, @pos.last - 1]
    left = [@pos.first, @pos.last - 1]
    top_left = [@pos.first - 1, @pos.last - 1]
    [top, top_right, right, bottom_right, bottom, bottom_left, left, top_left]
      .select { |pos| pos.all? { |i| (0..@board_size).include?(i) } }
      .map { |pos| @board[pos] }
  end

  def neighbors_bomb_count
    self.neighbors.count { |tile| tile.bombed? }
  end

  def scout
    return self if self.revealed?
    return self if self.flagged?
    self.reveal
    if !self.bombed? && !self.any_neighbors_bomb?
      self.neighbors.each { |tile| tile.scout }
    end
    self
  end

  def any_neighbors_bomb?
    self.neighbors_bomb_count != 0
  end

  def reveal
    @revealed = true
  end

  def revealed?
    @revealed
  end


  def flag
    @flagged = !@flagged unless @revealed
  end

  def flagged?
    @flagged
  end

  def bomb
    @bombed = true
  end

  def bombed?
    @bombed
  end
end
