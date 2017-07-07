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

  scenario 'by signing out' do
    login_as(member, scope: :member)
    visit root_path
    expect(page).to have_content('Sign out')
    click_link 'Sign out'
    expect(page).to have_content('Sign in')
    expect(page).to have_content('Signed out successfully.')
  end

  scenario "by changing one's password" do
    login_as(member, scope: :member)
    visit root_path
    expect(page).to have_content('Sign out')
    click_link 'Settings'
    expect(page).to have_content('Edit Member')

    fill_in 'member[password]', with: 'mynewpassword123'
    fill_in 'member[password_confirmation]', with: 'mynewpassword123'
    fill_in 'member[current_password]', with: member.password
    click_button 'Update'
    expect(page).to have_content('Your account has been updated successfully.')
  end
end
