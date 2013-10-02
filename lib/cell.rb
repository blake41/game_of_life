
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
      "<td></td>"
    else
      "<td class='dead'></td>"
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
    if self.alive?
      state = case alive_neighbors
        when 0..1
          false
        when 2..3
          true
        when 4..8
          false
        end
    else
      state = case alive_neighbors
        when 3
          true
        else
          false
        end
    end
    return state
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

class AliveCell < Cell

  def set_state
    self.alive = true
  end

end