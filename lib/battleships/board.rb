require_relative 'cell'
require_relative 'coordinate_handler'
require_relative 'random_generator'
require_relative 'ship'

module Battleships
  class Board
    SIZE = 10

    attr_accessor :width, :random_generator

    def initialize
      @grid = {}
      @coord_handler = CoordinateHandler.new
      @random_generator = RandomGenerator.new
      @ships = []
      initialize_grid
    end

    def place_ship ship, coordinate, orientation = :horizontally
      coords = ship_coords ship, coordinate, orientation

      coords.each { |coord| grid[coord].content = ship }
      @ships << ship
    end

    def place_random_vertical_ship
      ship = random_generator.random_ship
      letter = random_generator.random_letter
      coord = (letter + '1').to_sym
      place_ship(Ship.new(ship), coord, :vertically)
    end

    def place_random_horizontal_ship
      ship = random_generator.random_ship
      number = random_generator.random_number
      coord = ('E' + number.to_s).to_sym
      place_ship(Ship.new(ship), coord, :horizontally)
    end

    def width
      SIZE
    end

    def height
      SIZE
    end

    def ships
      # note we do not pass the source array here as it would enable
      # callers to modify the board's ships, which would break encapsulation.
      # Instead we return a duplicate.
      @ships.dup
    end

    def receive_shot coordinate
      coord_handler.validate coordinate

      validate_coord_not_shot coordinate

      cell = grid[coordinate]
      cell.receive_shot

      if cell.content
        cell.content.sunk? ? :sunk : :hit
      else
        :miss
      end
    end

    def receive_random_shot
      coordinate = (random_generator.random_letter + random_generator.random_all_number.to_s).to_sym
      receive_shot(coordinate)
    end

    def [] coordinate
      coord_handler.validate coordinate
      grid[coordinate]
    end

    def all_ships_sunk?
      return false if ships.empty?
      ships.all?(&:sunk?)
    end

    def inspect
      to_s
    end

    private

    attr_reader :grid, :coord_handler

    def initialize_grid
      coord_handler.each do |coord|
        grid[coord] = Cell.new
      end
    end

    def ship_coords ship, coord, orientation
      coord_handler.validate coord
      ship_coords = coord_handler.from coord, ship.size, orientation
      validate_ship_coords ship_coords, ship.size
    end

    def validate_ship_coords coords, size
      #ship is out of bounds if the ship is larger than the available coords
      fail 'Out of bounds' if size > coords.length

      validate_all_coords_available coords
    end

    def validate_all_coords_available coords
      coords.each do |coord|
        fail 'Coordinate already occupied' unless grid[coord].empty?
      end
    end

    def validate_coord_not_shot coord
      fail 'Coordinate has been shot already' if grid[coord].shot?
    end
  end
end
