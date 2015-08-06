require 'spec_helper'

feature 'Starting a new single player game' do
  scenario 'Starting a new single player game' do
    visit '/'
    click_button 'Single Player'
    expect(page).to have_content "What's your name?"
  end

  scenario 'Give you a form to fill in your name' do
    visit '/'
    click_button 'Single Player'
    fill_in('name', with: 'Adrian')
    click_button('Submit')
    expect(page).to have_content "Let's place your battleships, Adrian!"
  end

  scenario 'Stays on the same page if you do not fill in your name' do
    visit '/'
    click_button 'Single Player'
    fill_in('name', with: '')
    click_button('Submit')
    expect(current_path).to eq '/new_game'
  end

  scenario 'Player gets a new board after they press go to board' do
    visit '/'
    click_button 'Single Player'
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
    visit '/'
    click_button 'Single Player'
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
end
