require 'rails_helper'

feature 'member registers for site' do
  scenario 'Member registers' do
    visit root_path
    expect(page).to have_text('Welcome to the Photo App')
    click_link 'Share photos now!'
    fill_in_registration_fields
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end

  private

  def fill_in_registration_fields
    fill_in 'member[first_name]', with: Faker::Name.first_name
    fill_in 'member[last_name]', with: Faker::Name.last_name
    fill_in 'member[email]', with: Faker::Internet.email
    password = Devise.friendly_token.first(8)
    fill_in 'member[password]', with: password
    fill_in 'member[password_confirmation]', with: password
    click_button 'Sign up'
  end
end
