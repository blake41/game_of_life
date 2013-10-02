class Game

  attr_accessor :board

  def initialize(board)
    @board = board
  end

  def display_state
    puts self.board.display
  end

  def display_array
    self.board.display_array
  end

  def next_generation
    self.board = self.board.update_cells
  end

end
