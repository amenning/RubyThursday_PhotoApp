require 'rails_helper'

RSpec.describe Album, type: :model do
  describe 'validations' do
    it 'has a valid factory' do
      expect(FactoryGirl.create(:album)).to be_valid
    end
  end
  describe 'associations' do
    it { should belong_to(:member) }
    it { should have_many(:images) }
    it { should have_many(:album_groups) }
    it { should have_many(:groups).through(:album_groups) }
  end
end
