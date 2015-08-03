require 'sinatra/base'

class BattleshipWeb < Sinatra::Base
  get '/' do
    'Hello BattleshipWeb!'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
