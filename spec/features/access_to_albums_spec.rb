require 'rails_helper'

feature 'access to albums' do
  scenario 'is restricted to members so non-members are redirected to sign in' do
    album = FactoryGirl.create(:album)
    visit album_path(album)
    expect(page).to have_content('Log in')
  end

  scenario 'is restricted for editing to album owner' do
    album = FactoryGirl.create(:album)
    non_owner = FactoryGirl.create(:member)
    login_as(non_owner, scope: :member)

    visit edit_album_path(album)
    expect(page).to have_content('You are not authorized to perform this action.')
  end

  scenario 'is restricted for showing  to members following or owning album' do
    album = FactoryGirl.create(:album)
    non_owner_or_follower = FactoryGirl.create(:member)
    login_as(non_owner_or_follower, scope: :member)

    visit album_path(album)
    expect(page).to have_content('You are not authorized to perform this action.')
  end

  scenario 'is restricted for Adding Groups to album owner' do
    image = FactoryGirl.create(:image)
    album = image.album
    album_owner = album.member
    album_follower = FactoryGirl.create(:member, first_name: 'Album Follower')
    group = Group.create(name: 'The Wahnishes', member: album_owner)
    AlbumGroup.create(album: album, group: group)
    GroupMember.create(member: album_follower, group: group)

    login_as(album_follower, scope: :member)

    visit album_path(album)
    expect(page).to have_content album.title
    expect(current_path).to eq album_path(album)
    expect(page).not_to have_content('Add Group Access')
  end
end
