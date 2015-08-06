require 'battleships/random_generator'

describe RandomGenerator do
  it 'generates a random ship' do
    allow(subject.ships).to receive(:sample) { 'destroyer' }
    expect(subject.random_ship).to eq 'destroyer'
  end

  it 'generates a random letter' do
    allow(subject.letters).to receive(:sample) { 'A' }
    expect(subject.random_letter).to eq 'A'
  end

  it 'generates a random number' do
    allow(subject.numbers).to receive(:sample) { 6 }
    expect(subject.random_number).to eq 6
  end
end
