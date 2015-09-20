class RandomGenerator

  attr_reader :game, :ships, :directions, :letters, :numbers

  def initialize
    @letters = [*'A'..'J']
    @numbers = [*1..10]
    @directions = [:Vertically, :Horizontally]
    @ships = ['destroyer', 'submarine', 'battleship', 'aircraft_carrier', 'cruiser']
  end

  def get_random_coordinates
    (letters.sample + numbers.sample.to_s).to_sym
  end

  def get_random_directions
    directions.sample
  end

  def get_random_ship
    ships.sample
  end
end
