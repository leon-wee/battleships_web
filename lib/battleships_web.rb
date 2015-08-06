require 'sinatra/base'
require 'shotgun'
require_relative './battleships'

class BattleshipWeb < Sinatra::Base
  enable :sessions
  set :views, proc { File.join(root, '..', 'views') }

  get '/' do
    erb :index, layout: false
  end

  post '/' do
    session[:mode] = params[:mode]
    erb :index, layout: false
    redirect '/new_game'
  end

  get '/new_game' do
    erb :new_game
  end

  post '/new_game' do
    session[:name] = params[:name]
    session[:name2] = params[:name2]
    condition = session[:mode] == 'singleplayer' ? false : session[:name2].empty?
    redirect '/new_game' if session[:name].empty? || condition
    redirect '/new_board' if session[:mode] == 'singleplayer'
    redirect '/new_board' unless session[:name].empty? || session[:name2].empty?
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

  get '/new_board2' do
    session[:turn] = 'player_1'
    erb :new_board2
  end

  post '/new_board2' do
    @ship = params[:ship]
    @coordinate = params[:coordinate]
    @direction = params[:direction]
    $game.player_2.place_ship(Ship.new(@ship), @coordinate.to_sym, @direction.to_sym)
    erb :new_board2
  end

  get '/gameplay' do
    $game.player_2.place_random_vertical_ship
    $game.player_2.place_random_horizontal_ship
    erb :gameplay
  end

  post '/gameplay' do
    @coordinate = params[:coordinate]
    $game.player_1.shoot(@coordinate.to_sym)
    $game.player_2.random_shoot
    redirect '/results' if $game.has_winner?
    erb :gameplay
  end

  get '/multi_gameplay' do
    erb :multi_gameplay
  end

  post '/multi_gameplay' do
    @coordinate = params[:coordinate]
    session[:turn] == 'player_1' ? $game.player_1.shoot(@coordinate.to_sym) : $game.player_2.shoot(@coordinate.to_sym)
    redirect '/results' if $game.has_winner?
    erb :multi_gameplay
  end

  get '/switch' do
    session[:turn] = (session[:turn] == 'player_1' ? 'player_2' : 'player_1')
    redirect '/multi_gameplay'
  end

  get '/results' do
    erb :results
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
