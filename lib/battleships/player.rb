module Battleships
  class Player
    attr_accessor :board, :opponent, :name

    def place_ship ship, coordinates, orientation = :horizontally
      board.place_ship ship, coordinates, orientation
    end

    def place_random_vertical_ship
      board.place_random_vertical_ship
    end

    def place_random_horizontal_ship
      board.place_random_horizontal_ship
    end

    def shoot coordinates
      fail 'Player has no opponent' unless opponent
      opponent.receive_shot coordinates
    end

    def receive_shot coordinates
      fail 'Player has no board' unless board
      board.receive_shot coordinates
    end

    def random_shoot
      opponent.receive_random_shot
    end

    def receive_random_shot
      board.receive_random_shot
    end

    def winner?
      fail 'Player has no opponent' unless opponent
      opponent.all_ships_sunk?
    end

    def all_ships_sunk?
      fail 'Player has no board' unless board
      board.all_ships_sunk?
    end
  end
end
