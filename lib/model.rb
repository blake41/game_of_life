require 'debugger'
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

class Cell

  attr_accessor :alive

  def alive?
    if self.alive
      return true
    else
      return false
    end
  end

  def set_state
    num = Kernel.rand(2)
    if num == 1
      self.alive = true
    end
  end

  def display
    if self.alive?
      "o"
    else
      "."
    end
  end

  def location
    @location ||= {}
  end

  def set_location(i,j)
    self.location[:row] = i
    self.location[:column] = j
  end

  def update_state(board)
    alive_neighbors = self.count_alive_neighbors(board)
    state = case alive_neighbors
      when 0..1
        false
      when 2..3
        true
      when 4..8
        false
      end
  end

  def count_alive_neighbors(board)
    alive_neighbors = 0
    [:top, :top_right, :top_left, :left, :right, :bottom_right, :bottom, :bottom_left].each do |neighbor|
      if self.send(neighbor, board)
        alive_neighbors += 1
      end
    end
    return alive_neighbors
  end

  def top_right(board)
    self.check_neighbor(board, -1, 1)
  end

  def bottom_right(board)
    self.check_neighbor(board, 1 , 1)
  end

  def top(board)
    self.check_neighbor(board, -1, 0)
  end

  def bottom(board)
    self.check_neighbor(board, 1, 0)
  end

  def top_left(board)
    self.check_neighbor(board, -1, -1)
  end

  def bottom_left(board)
    self.check_neighbor(board, 1, -1)
  end

  def left(board)
    self.check_neighbor(board, 0, -1)
  end

  def right(board)
    self.check_neighbor(board, 0, 1)
  end

  def check_neighbor(board, row, column)
    return false if board.state[self.location[:row] + row].nil?
    return false if (self.location[:row] + row < 0)
    return false if (self.location[:column] + column) < 0
    cell = board.state[self.location[:row] + row][self.location[:column] + column]
    return false if cell.nil?
    if cell.alive?
      return true
    else
      return false
    end
  end

end

class DeadCell < Cell

  def set_state
    self.alive = false
  end

end

class Board

  attr_accessor :state, :rows, :columns

  def initialize(cell_type = Cell)
    @state = []
    @cell_type = Cell
    @rows = 20
    @columns = 5
  end

  def cell(row, column)
    self.state[row][column]
  end

  def set_dimensions(rows, columns = 5)
    self.rows = rows
    self.columns = columns
  end

  def set_initial_state(cell_type)
    self.rows.times do |i|
      row = []
      self.columns.times do |j|
        row << self.set_state_of_cell(i,j, cell_type)
      end
      self.state << row
    end
  end

  def set_state_of_cell(i,j, cell_type)
    cell = cell_type.new
    cell.set_state
    cell.set_location(i,j)
    cell
  end

  def display
    board_as_a_string = ""
    self.state.each do |row|
      row.each do |element|
        board_as_a_string << element.display
      end
      board_as_a_string << "\n"
    end
    board_as_a_string
  end

  def display_array
    self.state.collect do |row|
      row.collect do |element|
        element.display
      end
    end
  end


  def clone_board
    new_board = self.class.new
    new_board.rows = self.rows
    new_board.columns = self.columns
    new_board
  end

  def update_cells
    new_board = self.clone_board
    new_board.set_initial_state(DeadCell)
    self.state.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        # debugger
        new_board.state[i][j].alive = cell.update_state(self)
      end
    end
    new_board
  end

end

# board = Board.new
# board.set_dimensions(10,100)
# board.set_initial_state(Cell)
# game = Game.new(board)
# game.display_state
# game.next_generation

