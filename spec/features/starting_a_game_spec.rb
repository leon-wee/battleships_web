require 'spec_helper'

feature 'Starting a new game' do
  scenario 'Starting a new game' do
    visit '/'
    click_link 'New Game'
    expect(page).to have_content "What's your name?"
  end

  scenario 'Give you a form to fill in your name' do
    visit '/'
    click_link 'New Game'
    fill_in('name', with: 'Adrian')
    click_button('Submit')
    expect(page).to have_content "Let's play battleship, Adrian!"
  end

  scenario 'Stays on the same page if you do not fill in your name' do
    visit '/new_game'
    fill_in('name', with: '')
    click_button('Submit')
    expect(current_path).to eq '/new_game'
  end

  scenario 'Player gets a new board after they press go to board' do
    visit '/new_game'
    fill_in('name', with: 'Adrian')
    click_button('Submit')
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
10|          |10
  ------------
   ABCDEFGHIJ')
  end

  scenario 'Player can place a ship on the board' do
    visit '/new_game'
    fill_in('name', with: 'Adrian')
    click_button('Submit')
    fill_in('coordinate', with: 'A1')
    select('Destroyer', from: 'ship')
    choose('Vertically')
    click_button('Place Ship')
    expect(page).to have_content(
    'ABCDEFGHIJ
  ------------
 1|D         |1
 2|D         |2
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

  scenario 'Board should have a randomly placed ship' do
    visit '/new_game'
    fill_in('name', with: 'Adrian')
    click_button('Submit')
    expect($game.player_2).to receive(:place_random_vertical_ship)
    click_button('Start Game')
  end

    scenario 'Board should have a randomly placed ship' do
    visit '/new_game'
    fill_in('name', with: 'Adrian')
    click_button('Submit')
    expect($game.player_2).to receive(:place_random_horizontal_ship)
    click_button('Start Game')
  end

  scenario 'Player can fire at the board' do
    visit '/new_board'
    fill_in('coordinate', with: 'A1')
    select('Destroyer', from: 'ship')
    choose('Vertically')
    click_button('Place Ship')
    click_button('Start Game')
    expect(page).to have_button('Fire')
  end

  scenario 'Player can see the hit on the board' do
    visit '/new_board'
    allow($game.player_2).to receive(:place_random_vertical_ship) { $game.player_2.place_ship(Ship.submarine, :A1) }
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
    visit '/new_board'
    allow($game.player_2).to receive(:place_random_vertical_ship) { $game.player_2.place_ship(Ship.submarine, :A1) }
    click_button('Start Game')
    fill_in('coordinate', with: 'A3')
    click_button('Fire')
    expect(page).to have_content(
    'ABCDEFGHIJ
  ------------
 1|          |1
 2|          |2
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
end
