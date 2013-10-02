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

  def set_cell(row,column, cell)
    self.state[row][column] = cell 
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

  def insert_cell(i,j,cell_type = AliveCell)
    cell = set_state_of_cell(i,j,cell_type)
    self.set_cell(i,j,cell)
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
    self.state
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
        new_board.state[i][j].alive = cell.update_state(self)
      end
    end
    new_board
  end
end