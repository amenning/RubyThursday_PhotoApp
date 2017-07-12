require 'rails_helper'

feature 'member manages images' do
  let!(:album) { FactoryGirl.create(:album) }

  scenario 'by creating a new image' do
    member = album.member
    login_as(member, scope: :member)
    visit root_path
    click_link 'Dashboard'
    expect(page).to have_content 'My Dashboard'

    click_link 'View Albums'
    expect(page).to have_content album.title

    click_link 'View Album'
    click_link 'ADD NEW POST TO THIS ALBUM'
    image_path = 'spec/fixtures/files/example_image.jpg'
    attach_file 'image[album_image]', image_path
    fill_in 'image[title]', with: "Julia's 1st 4th of July"
    fill_in 'image[date_taken]', with: Date.yesterday
    click_button 'Add Image'
    expect(page).to have_content 'Image was successfully created.'
    expect(page).to have_content album.title
    expect(Image.count).to eq 1
    image = Image.last
    expect(image).to have_attributes(
      title: "Julia's 1st 4th of July",
      album_id: album.id,
      date_taken: Date.yesterday,
      album_image_file_name: 'example_image.jpg'
    )
  end
end
