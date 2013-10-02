require_relative "game_of_life_solution"

describe "game" do
  before(:each) do
    @board = Board.new
    @board.set_dimensions(3,3)
    3.times do
      @board.state << []
    end
    @board.state[0][0] = @board.set_state_of_cell(0,0, DeadCell)
    @board.state[0][1] = @board.set_state_of_cell(0,1, DeadCell)
    @board.state[0][2] = @board.set_state_of_cell(0,2, AliveCell)
    @board.state[1][0] = @board.set_state_of_cell(1,0, DeadCell)
    @board.state[1][1] = @board.set_state_of_cell(1,1, AliveCell)
    @board.state[1][2] = @board.set_state_of_cell(1,2, AliveCell)
    @board.state[2][0] = @board.set_state_of_cell(2,0, AliveCell)
    @board.state[2][1] = @board.set_state_of_cell(2,1, DeadCell)
    @board.state[2][2] = @board.set_state_of_cell(2,2, AliveCell)
    @game = Game.new(@board)
  end
  describe "cell types" do
    it "should be false for alive? if its a deadcell class" do
      @board.cell(0,0).alive?.should be_false
    end

    it "should be true for alive? if its an alivecell class" do
      @board.cell(0,2).alive?.should be_true
    end
  end

  describe "state changes" do
    
    it "should know how many neighbors are alive" do
      @board.cell(1,1).count_alive_neighbors(@board).should eq(4)
    end

    it "Rule#1 a dead cell with greater or less than 3 neighbors should stay dead" do
      @board.cell(0,0).count_alive_neighbors(@board).should eq(1)
      @board.cell(0,0).update_state(@board).should be_false
    end

    it "a dead cell with exactly 3 live neighbors should come alive" do
      @board.cell(0,1).count_alive_neighbors(@board).should eq(3)
      @board.cell(0,1).update_state(@board).should be_true
    end

    it "An alive cell with more than 3 neighbors should die" do
      @board.cell(1,1).count_alive_neighbors(@board).should eq(4)
      @board.cell(1,1).update_state(@board).should be_false
    end

    it "An alive cell with exactly 2 neighbors should stay alive" do
      @board.cell(0,2).count_alive_neighbors(@board).should eq(2)
      @board.cell(0,2).update_state(@board).should be_true
    end

    it "An alive cell with exactly 3 neighbors should stay alive" do
      @board.cell(1,2).count_alive_neighbors(@board).should eq(3)
      @board.cell(1,2).update_state(@board).should be_true
    end
    
    it "An alive cell with less than 2 neighbors should die" do
      @board.cell(2,0).count_alive_neighbors(@board).should eq(1)
      @board.cell(2,0).update_state(@board).should be_false
    end

  end
end