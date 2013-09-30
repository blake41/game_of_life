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
    get '/game_of_life' do
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
      board.set_dimensions(10,100)
      board.set_initial_state(Cell)
      self.game = Game.new(board)
    end

    #helpers
    helpers do
      def partial(file_name)
        erb file_name, :layout => false
      end
    end

  end
end
