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

  scenario 'by viewing the ablum with images' do
    image = FactoryGirl.create(:image)
    album = image.album
    member = album.member

    login_as(member, scope: :member)
    visit root_path
    click_link 'Dashboard'
    expect(page).to have_content 'My Dashboard'

    click_link 'View Albums'
    expect(page).to have_content album.title
    click_link 'View Album'

    expect(page).to have_content image.title
    expect(page).to have_content image.date_taken
    expect(page).to have_css("img[src*='#{image.album_image.url(:medium)}']")
  end
end
