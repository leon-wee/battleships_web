require "spec_helper"

feature 'Starting a new multiplayer game' do
  scenario 'Starting a new two player game' do
    visit '/'
    click_button 'Multiplayer'
    expect(page).to have_content "What's your name?"
  end

  scenario "Gives you the chance to fill in yours and opponent's name" do
    visit '/'
    click_button 'Multiplayer'
    fill_in('name', with: 'Adrian')
    fill_in('name2', with: 'Bob')
    click_button('Submit')
    expect(page).to have_content "Let's place your battleships, Adrian!"
  end

  scenario 'Stays on the same page if both names are not entered' do
    visit '/'
    click_button 'Multiplayer'
    fill_in('name', with: 'Adrian')
    fill_in('name2', with: '')
    click_button('Submit')
    expect(current_path).to eq '/new_game'
  end

  scenario 'Your opponent gets to place ships after you have' do
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
    expect(page).to have_content "Let's place your battleships, Bob!"
  end
end
