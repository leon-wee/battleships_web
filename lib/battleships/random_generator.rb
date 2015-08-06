class RandomGenerator
  attr_reader :ships, :letters, :numbers, :all_numbers

  def initialize
    @ships = ['submarine', 'destroyer', 'cruiser', 'battleship', 'aircraft_carrier']
    @letters = ('A'..'J').to_a
    @numbers = [*6..10]
    @all_numbers = [*1..10]
  end

  def random_ship
    ships.sample
  end

  def random_letter
    letters.sample
  end

  def random_number
    numbers.sample
  end

  def random_all_number
    all_numbers.sample
  end
end
