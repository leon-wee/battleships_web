require 'battleships/random_generator'

describe RandomGenerator do
  it 'generates a random ship' do
    allow(subject.ships).to receive(:sample) { 'destroyer' }
    expect(subject.get_random_ship).to eq 'destroyer'
  end

  it 'generates a random coordinate' do
    allow(subject.letters).to receive(:sample) { 'A' }
    allow(subject.numbers).to receive(:sample) { 2 }
    expect(subject.get_random_coordinates).to eq :A2
  end

  it 'generates random direction' do
    allow(subject.directions).to receive(:sample) { :Vertically }
    expect(subject.get_random_direction).to eq :Vertically
  end

end
