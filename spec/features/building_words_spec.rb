require 'spec_helper'

feature 'A Scrabble cheater' do

  scenario 'can visit the homepage' do
    visit '/'
    expect(page).to have_content 'Scrabblegram'
    expect(page).to have_selector '#letters'
  end

  scenario 'can enter a string of letters' do
    visit '/'
    fill_in 'letters', with: 'spike'
    fill_in 'number', with: '10'
    click_button 'Go!'
    expect(page).to have_selector '.result-container', count: 10
  end

end