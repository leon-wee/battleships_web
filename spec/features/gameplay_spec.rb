require 'spec_helper'

feature 'Playing single player' do
  scenario 'Board should have a randomly placed ship' do
    visit '/'
    click_button 'Single Player'
    fill_in('name', with: 'Leon')
    click_button('Submit')
    expect($game.player_2).to receive(:place_random_ships)
    click_button('Start Game')
  end

  scenario 'Player can fire at the board' do
    visit '/'
    click_button 'Single Player'
    fill_in('name', with: 'Adrian')
    click_button('Submit')
    fill_in('coordinate', with: 'A1')
    select('Destroyer', from: 'ship')
    choose('Vertically')
    click_button('Place Ship')
    click_button('Start Game')
    expect(page).to have_button('Fire')
  end

  scenario 'Player can see the hit on the board' do
    visit '/'
    click_button 'Single Player'
    fill_in('name', with: 'Adrian')
    click_button('Submit')
    allow($game.player_2).to receive(:place_random_ships).and_return($game.player_2.place_ship(Ship.submarine, :A1), $game.player_2.place_ship(Ship.submarine, :A2), $game.player_2.place_ship(Ship.submarine, :A3), $game.player_2.place_ship(Ship.submarine, :A4), $game.player_2.place_ship(Ship.submarine, :A5))
    click_button('Start Game')
    fill_in('coordinate', with: 'A1')
    click_button('Fire')
    expect(page).to have_content(
    'ABCDEFGHIJ
  ------------
 1|*         |1
 2|          |2
 3|          |3
 4|          |4
 5|          |5
 6|          |6
 7|          |7
 8|          |8
 9|          |9
10|          |10
  ------------
   ABCDEFGHIJ')
    end

  scenario 'Player can see the miss on the board' do
    visit '/'
    click_button 'Single Player'
    fill_in('name', with: 'Adrian')
    click_button('Submit')
    allow($game.player_2).to receive(:place_random_ships).and_return($game.player_2.place_ship(Ship.submarine, :A1), $game.player_2.place_ship(Ship.submarine, :A2), $game.player_2.place_ship(Ship.submarine, :A3), $game.player_2.place_ship(Ship.submarine, :A4), $game.player_2.place_ship(Ship.submarine, :A5))
    click_button('Start Game')
    fill_in('coordinate', with: 'J10')
    click_button('Fire')
    expect(page).to have_content(
    'ABCDEFGHIJ
  ------------
 1|          |1
 2|          |2
 3|          |3
 4|          |4
 5|          |5
 6|          |6
 7|          |7
 8|          |8
 9|          |9
10|         -|10
  ------------
   ABCDEFGHIJ')
  end

  scenario 'Computer randomly fires back at the player' do
    visit '/'
    click_button 'Single Player'
    fill_in('name', with: 'Adrian')
    click_button('Submit')
    fill_in('coordinate', with: 'A1')
    select('Destroyer', from: 'ship')
    choose('Vertically')
    click_button('Place Ship')
    click_button('Start Game')
    fill_in('coordinate', with: 'A1')
    allow($game.player_2).to receive(:random_shoot) { $game.player_2.shoot(:A3) }
    click_button('Fire')
    expect(page).to have_content(
    'ABCDEFGHIJ
  ------------
 1|D         |1
 2|D         |2
 3|-         |3
 4|          |4
 5|          |5
 6|          |6
 7|          |7
 8|          |8
 9|          |9
10|          |10
  ------------
   ABCDEFGHIJ')
  end

  scenario 'it goes to results page when game is finished' do
    visit '/'
    click_button 'Single Player'
    fill_in('name', with: 'Leon')
    click_button('Submit')
    fill_in('coordinate', with: 'A1')
    select('Destroyer', from: 'ship')
    choose('Vertically')
    click_button('Place Ship')
    allow($game.player_2).to receive(:place_random_ships).and_return($game.player_2.place_ship(Ship.submarine, :A1), $game.player_2.place_ship(Ship.submarine, :A2), $game.player_2.place_ship(Ship.submarine, :A3), $game.player_2.place_ship(Ship.submarine, :A4), $game.player_2.place_ship(Ship.submarine, :A5))
    click_button('Start Game')
    fill_in('coordinate', with: 'A1')
    click_button('Fire')
    fill_in('coordinate', with: 'A2')
    click_button('Fire')
    fill_in('coordinate', with: 'A3')
    click_button('Fire')
    fill_in('coordinate', with: 'A4')
    click_button('Fire')
    fill_in('coordinate', with: 'A5')
    click_button('Fire')
    expect(current_path).to eq '/results'
  end

  scenario 'it says player 1 wins when player 1 wins' do
    visit '/'
    click_button 'Single Player'
    fill_in('name', with: 'Leon')
    click_button('Submit')
    fill_in('coordinate', with: 'A1')
    select('Destroyer', from: 'ship')
    choose('Vertically')
    click_button('Place Ship')
    allow($game.player_2).to receive(:place_random_ships).and_return($game.player_2.place_ship(Ship.submarine, :A1), $game.player_2.place_ship(Ship.submarine, :A2), $game.player_2.place_ship(Ship.submarine, :A3), $game.player_2.place_ship(Ship.submarine, :A4), $game.player_2.place_ship(Ship.submarine, :A5))
    click_button('Start Game')
    fill_in('coordinate', with: 'A1')
    click_button('Fire')
    fill_in('coordinate', with: 'A2')
    click_button('Fire')
    fill_in('coordinate', with: 'A3')
    click_button('Fire')
    fill_in('coordinate', with: 'A4')
    click_button('Fire')
    fill_in('coordinate', with: 'A5')
    click_button('Fire')
    expect(current_path).to eq '/results'
    expect(page).to have_content 'You have won!'
  end

  scenario 'it says player 1 loses when player 1 loses' do
    visit '/'
    click_button 'Single Player'
    fill_in('name', with: 'Adrian')
    click_button('Submit')
    fill_in('coordinate', with: 'A1')
    select('Submarine', from: 'ship')
    choose('Vertically')
    click_button('Place Ship')
    click_button('Start Game')
    fill_in('coordinate', with: 'A1')
    allow($game.player_2).to receive(:random_shoot) { $game.player_2.shoot(:A1) }
    click_button('Fire')
    expect(page).to have_content 'You have lost!'
  end
end
