require 'rails_helper'

RSpec.describe Member, type: :model do
  describe 'validations' do
    it 'has a valid factory' do
      expect(FactoryGirl.create(:member)).to be_valid
    end
  end
  describe 'associations' do
    it { should have_many(:albums) }
    it { should have_many(:groups) }
    it { should have_many(:group_members) }
    it { should have_many(:group_memberships).class_name('Group').through(:group_members) }
  end
end
