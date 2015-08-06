require 'sinatra/base'
require 'shotgun'
require_relative './battleships'

class BattleshipWeb < Sinatra::Base
  enable :sessions

  get '/' do
    erb :index, layout: false
  end

  get '/new_game' do
    erb :new_game
  end

  post '/new_game' do
    session[:name] = params[:name]
    redirect '/new_game' if session[:name] == ''
    redirect '/new_board'
  end

  get '/new_board' do
    $game = Game.new(Player, Board)
    erb :new_board
  end

  post '/new_board' do
    @ship = params[:ship]
    @coordinate = params[:coordinate]
    @direction = params[:direction]
    $game.player_1.place_ship(Ship.new(@ship), @coordinate.to_sym, @direction.to_sym)
    erb :new_board
  end

  get '/gameplay' do
    $game.player_2.place_random_vertical_ship
    $game.player_2.place_random_horizontal_ship
    erb :gameplay
  end

  post '/gameplay' do
    @coordinate = params[:coordinate]
    $game.player_1.shoot(@coordinate.to_sym) unless @coordinate.nil?
    erb :gameplay
  end

  set :views, proc { File.join(root, '..', 'views') }

  # start the server if ruby file executed directly
  run! if app_file == $0
end
