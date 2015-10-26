require 'spec_helper'

RSpec.feature "googling browserstack", js: true do
  it 'is good' do
    visit 'http://google.com'
    fill_in "q", with: "Browserstack is good"
    click_button 'Search'
    expect(page).to have_title("Browserstack is good - Google Search")
  end

  it 'is great' do
    visit 'http://google.com'
    fill_in "q", with: "Browserstack is great"
    click_button 'Search'
    expect(page).to have_title("Browserstack is great - Google Search")
  end
end
