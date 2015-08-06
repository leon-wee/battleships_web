require "spec_helper"

feature 'Playing multiplayer' do
  scenario 'You can fire at the opponent' do
    visit '/'
    click_button 'Multiplayer'
    fill_in('name', with: 'Adrian')
    fill_in('name2', with: 'Bob')
    click_button('Submit')
    fill_in('coordinate', with: 'A1')
    select('Destroyer', from: 'ship')
    choose('Vertically')
    click_button('Place Ship')
    click_button("Opponent's turn")
    fill_in('coordinate', with: 'B1')
    select('Destroyer', from: 'ship')
    choose('Vertically')
    click_button('Place Ship')
    click_button('Start Game')
    fill_in('coordinate', with: 'B1')
    click_button('Fire')
    expect(page).to have_content("Let's play battleship, Adrian!
Player Own
   ABCDEFGHIJ
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
   ABCDEFGHIJ
Player Opponent
   ABCDEFGHIJ
  ------------
 1| *        |1
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
   ABCDEFGHIJ")
  end

  scenario 'You can pass turn to the opponent' do
    visit '/'
    click_button 'Multiplayer'
    fill_in('name', with: 'Adrian')
    fill_in('name2', with: 'Bob')
    click_button('Submit')
    fill_in('coordinate', with: 'A1')
    select('Destroyer', from: 'ship')
    choose('Vertically')
    click_button('Place Ship')
    click_button("Opponent's turn")
    fill_in('coordinate', with: 'B1')
    select('Destroyer', from: 'ship')
    choose('Vertically')
    click_button('Place Ship')
    click_button('Start Game')
    fill_in('coordinate', with: 'B1')
    click_button('Fire')
    expect(page).to have_button("Opponent's turn")
  end

  scenario 'You cannot fire twice' do
    visit '/'
    click_button 'Multiplayer'
    fill_in('name', with: 'Adrian')
    fill_in('name2', with: 'Bob')
    click_button('Submit')
    fill_in('coordinate', with: 'A1')
    select('Destroyer', from: 'ship')
    choose('Vertically')
    click_button('Place Ship')
    click_button("Opponent's turn")
    fill_in('coordinate', with: 'B1')
    select('Destroyer', from: 'ship')
    choose('Vertically')
    click_button('Place Ship')
    click_button('Start Game')
    fill_in('coordinate', with: 'B1')
    click_button('Fire')
    expect(page).to_not have_button('Fire')
  end

  scenario 'Opponent can fire at you' do
    visit '/'
    click_button 'Multiplayer'
    fill_in('name', with: 'Adrian')
    fill_in('name2', with: 'Bob')
    click_button('Submit')
    fill_in('coordinate', with: 'A1')
    select('Destroyer', from: 'ship')
    choose('Vertically')
    click_button('Place Ship')
    click_button("Opponent's turn")
    fill_in('coordinate', with: 'B1')
    select('Destroyer', from: 'ship')
    choose('Vertically')
    click_button('Place Ship')
    click_button('Start Game')
    fill_in('coordinate', with: 'B1')
    click_button('Fire')
    click_button("Opponent's turn")
    fill_in('coordinate', with: 'A1')
    click_button('Fire')
    expect(page).to have_content("Let's play battleship, Bob!
Player Own
   ABCDEFGHIJ
  ------------
 1| *        |1
 2| D        |2
 3|          |3
 4|          |4
 5|          |5
 6|          |6
 7|          |7
 8|          |8
 9|          |9
10|          |10
  ------------
   ABCDEFGHIJ
Player Opponent
   ABCDEFGHIJ
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
   ABCDEFGHIJ")
  end

  scenario 'You can pass turn to the opponent' do
    visit '/'
    click_button 'Multiplayer'
    fill_in('name', with: 'Adrian')
    fill_in('name2', with: 'Bob')
    click_button('Submit')
    fill_in('coordinate', with: 'A1')
    select('Destroyer', from: 'ship')
    choose('Vertically')
    click_button('Place Ship')
    click_button("Opponent's turn")
    fill_in('coordinate', with: 'B1')
    select('Destroyer', from: 'ship')
    choose('Vertically')
    click_button('Place Ship')
    click_button('Start Game')
    fill_in('coordinate', with: 'B1')
    click_button('Fire')
    click_button("Opponent's turn")
    fill_in('coordinate', with: 'A1')
    click_button('Fire')
    expect(page).to have_button("Opponent's turn")
  end

  scenario 'You cannot fire twice' do
    visit '/'
    click_button 'Multiplayer'
    fill_in('name', with: 'Adrian')
    fill_in('name2', with: 'Bob')
    click_button('Submit')
    fill_in('coordinate', with: 'A1')
    select('Destroyer', from: 'ship')
    choose('Vertically')
    click_button('Place Ship')
    click_button("Opponent's turn")
    fill_in('coordinate', with: 'B1')
    select('Destroyer', from: 'ship')
    choose('Vertically')
    click_button('Place Ship')
    click_button('Start Game')
    fill_in('coordinate', with: 'B1')
    click_button('Fire')
    click_button("Opponent's turn")
    fill_in('coordinate', with: 'A1')
    click_button('Fire')
    expect(page).to_not have_button('Fire')
  end

  scenario 'Player 1 sees winning message' do
    visit '/'
    click_button 'Multiplayer'
    fill_in('name', with: 'Adrian')
    fill_in('name2', with: 'Bob')
    click_button('Submit')
    fill_in('coordinate', with: 'A1')
    select('Destroyer', from: 'ship')
    choose('Vertically')
    click_button('Place Ship')
    click_button("Opponent's turn")
    fill_in('coordinate', with: 'B1')
    select('Destroyer', from: 'ship')
    choose('Vertically')
    click_button('Place Ship')
    click_button('Start Game')
    fill_in('coordinate', with: 'B1')
    click_button('Fire')
    click_button("Opponent's turn")
    fill_in('coordinate', with: 'A1')
    click_button('Fire')
    click_button("Opponent's turn")
    fill_in('coordinate', with: 'B2')
    click_button('Fire')
    expect(page).to have_content('You have won!')
  end

  scenario 'Player 2 sees winning message' do
    visit '/'
    click_button 'Multiplayer'
    fill_in('name', with: 'Adrian')
    fill_in('name2', with: 'Bob')
    click_button('Submit')
    fill_in('coordinate', with: 'A1')
    select('Destroyer', from: 'ship')
    choose('Vertically')
    click_button('Place Ship')
    click_button("Opponent's turn")
    fill_in('coordinate', with: 'B1')
    select('Destroyer', from: 'ship')
    choose('Vertically')
    click_button('Place Ship')
    click_button('Start Game')
    fill_in('coordinate', with: 'B1')
    click_button('Fire')
    click_button("Opponent's turn")
    fill_in('coordinate', with: 'A1')
    click_button('Fire')
    click_button("Opponent's turn")
    fill_in('coordinate', with: 'B3')
    click_button('Fire')
    click_button("Opponent's turn")
    fill_in('coordinate', with: 'A2')
    click_button('Fire')
    expect(page).to have_content('You have won!')
  end
end
