FactoryGirl.define do
  factory :album do
    title { Faker::Name.name }
    member
  end
end
