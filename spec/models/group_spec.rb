require 'rails_helper'

RSpec.describe Group, type: :model do
  describe 'validations' do
    it 'has a valid factory' do
      expect(FactoryGirl.create(:group)).to be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:member) }
    it { should have_many(:group_members) }
    it { should have_many(:group_memberships).class_name('Member').through(:group_members) }
    it { should have_many(:album_groups) }
    it { should have_many(:albums).through(:album_groups) }
  end
end
