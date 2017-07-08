require 'rails_helper'

feature 'member manages albums' do
  let(:member) { FactoryGirl.create(:member) }

  scenario 'by creating a new album' do
    login_as(member, scope: :member)
    visit root_path
    click_link 'Dashboard'
    expect(page).to have_content 'My Dashboard'

    click_link 'Create New Album'
    expect(page).to have_content 'Yay, create a new album!'

    fill_in 'album[title]', with: 'Julia'
    click_button 'Create Album'
    expect(page).to have_content 'Album was successfully created.'
    expect(page).to have_content 'Julia'
    expect(Album.count).to eq 1

    album = Album.last
    expect(album).to have_attributes(title: 'Julia', member_id: member.id)
  end
end
