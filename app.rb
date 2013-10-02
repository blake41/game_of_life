require 'bundler'
Bundler.require

Dir.glob('./lib/*.rb') do |model|
  require model
end

module Name
  class App < Sinatra::Application

    #configure
    configure do
      set :root, File.dirname(__FILE__)
      set :public_folder, 'public'
    end

    #database
    set :database, "sqlite3:///database.db"

    #filters

    #routes
    get '/' do
      if self.class.board.nil?
        puts "initializing board"
        self.class.initialize_board
      else
        puts "next"
        self.class.game.next_generation
      end
      @display = self.class.game.display_array
      erb :game_of_life
    end

    def self.game
      @game
    end

    def self.game=(game)
      @game = game
    end

    def self.board
      @board
    end

    def self.initialize_board
      @board = Board.new
      board.set_dimensions(35,150)
      board.set_initial_state(DeadCell)
      self.set_pattern
      self.game = Game.new(board)
    end

    def self.set_pattern
      self.spaceship(30, 40)
      self.glider(30, 90)
      self.long_vertical(10,10)
      self.podium(15, 15)
      self.rotated_L(20,15)
      self.spaceship(20, 60)
      self.spaceship(10, 40)
      self.spaceship(10, 30)
      self.spaceship(10, 25)
      self.spaceship(20, 80)
      self.spaceship(30, 50)
      self.podium(15, 5)
      self.podium(15, 25)
      self.podium(15, 35)
      self.podium(15, 45)
      self.podium(15, 55)
      self.podium(25, 5)
      self.podium(25, 25)
      self.podium(25, 35)
      self.podium(25, 45)
      self.podium(25, 55)
      self.podium(15, 65)
      self.podium(15, 75)
      self.podium(15, 85)
      self.podium(15, 95)
      self.podium(15, 50)
      self.podium(25, 65)
      self.podium(25, 75)
      self.podium(25, 85)
      self.podium(25, 95)
      self.podium(25, 50)
      self.podium(15, 115)
      self.podium(15, 125)
      self.podium(15, 135)
      self.podium(15, 145)
      self.podium(25, 115)
      self.podium(25, 125)
      self.podium(25, 135)
      self.podium(25, 145)
      self.podium(25, 105)
    end

    def self.spaceship(row, column)
      self.board.insert_cell(row,column)
      self.board.insert_cell(row,column + 3)
      self.board.insert_cell(row + 1,column - 1)
      self.board.insert_cell(row + 2,column - 1)
      self.board.insert_cell(row + 3,column - 1)
      self.board.insert_cell(row + 3,column)
      self.board.insert_cell(row + 3,column + 1)
      self.board.insert_cell(row + 3,column + 2)
      self.board.insert_cell(row + 2,column + 3)
    end

    def self.glider(row, column)
      self.board.insert_cell(row,column + 1)
      self.board.insert_cell(row,column + 2)
      self.board.insert_cell(row,column)
      self.board.insert_cell(row + 1,column)
      self.board.insert_cell(row + 2,column + 2)
    end

    def self.long_vertical(row,column)
      self.board.insert_cell(row,column, AliveCell)
      self.board.insert_cell(row + 1,column, AliveCell)
      self.board.insert_cell(row + 2,column, AliveCell)
      self.board.insert_cell(row + 3,column, AliveCell)
    end

    def self.podium(row, column)
      self.board.insert_cell(row,column, AliveCell)
      self.board.insert_cell(row + 1,column + 1, AliveCell)
      self.board.insert_cell(row + 1,column - 1, AliveCell)
      self.board.insert_cell(row + 1,column, AliveCell)
    end

    def self.rotated_L(row, column)
      self.board.insert_cell(row,column, AliveCell)
      self.board.insert_cell(row + 1,column, AliveCell)
      self.board.insert_cell(row,column + 1, AliveCell)
      self.board.insert_cell(row,column + 2, AliveCell)
    end

    #helpers
    helpers do
      def partial(file_name)
        erb file_name, :layout => false
      end
      def h(text)
        Rack::Utils.escape_html(text)
      end
    end

  end
end
