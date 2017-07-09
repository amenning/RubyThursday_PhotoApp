FactoryGirl.define do
  factory :image do
    title { Faker::Name.name }
    date_taken Date.yesterday
    album_image { fixture_file_upload 'spec/fixtures/files/example_image.jpg', 'image/jpg' }
    album
  end
end
