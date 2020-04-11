class Tile
  attr_accessor :value

  def initialize(value, revealed=false, flagged=false)
    @value = value
    @flagged = flagged
    @revealed = revealed
  end

  def to_s
    @revealed ? self.value.to_s : "|_|"
  end

  def reveal
    @revealed = true
  end

  def bombed?
    self.value == "*" ? true : false
  end

  def flagged?
    self.value == "F" ? true : false
  end

  def revealed?
    @revealed
  end

  def safe?
    self.value == "|_|" ? true : false
  end
end
