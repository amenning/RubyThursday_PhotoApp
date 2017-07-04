require 'rails_helper'

feature 'member manages account' do
  let!(:member) { FactoryGirl.create(:member) }

  scenario 'by signing in' do
    visit root_path
    expect(page).to have_content('Welcome to the Photo App')
    click_link 'Sign in'
    expect(page).to have_content('Log in')
    fill_in 'member[email]', with: member.email
    fill_in 'member[password]', with: member.password
    click_button 'Log in'
    expect(page).to have_text('Signed in successfully.')
  end
end
