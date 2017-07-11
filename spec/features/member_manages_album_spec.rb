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

  scenario 'by viewing link to the album as album follower' do
    image = FactoryGirl.create(:image)
    album = image.album
    album_owner = album.member
    album_follower = member
    group = Group.create(name: 'The Wahnishes', member: album_owner)
    AlbumGroup.create(album: album, group: group)
    GroupMember.create(member: album_follower, group: group)

    login_as(album_follower, scope: :member)
    visit root_path
    click_link 'Dashboard'
    expect(page).to have_content 'My Dashboard'

    click_link 'View Albums'
    expect(page).to have_content album.title
    expect(page).to have_link('View Album', href: album_path(album))
    click_link 'View Album'

    expect(page).to have_content image.title
    expect(page).to have_content image.date_taken
    expect(page).to have_css("img[src*='#{image.album_image.url(:medium)}']")
  end

  scenario 'by adding groups to have access to the album' do
    group = FactoryGirl.create(:group)
    album = FactoryGirl.create(:album, member: group.member)
    album_owner = album.member
    login_as(album_owner, scope: :member)
    visit album_path(album)
    expect(page).to have_content album.title

    click_link 'Add Group Access'
    expect(page).to have_content 'Select a Group to allow access to this Album'

    select group.name
    click_button 'Save Album'
    expect(page).to have_content 'Album was successfully updated.'
    expect(current_path).to eq album_path(album)
    expect(AlbumGroup.count).to eq 1

    album_group = AlbumGroup.last
    expect(album_group).to have_attributes(
      group_id: group.id,
      album_id: album.id
    )
  end
end
