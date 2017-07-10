require 'rails_helper'

RSpec.describe Member, type: :model do
  describe 'associations' do
    it { should have_many(:albums) }
    it { should have_many(:groups) }
    it { should have_many(:group_memberships).class_name('Group').through(:group_members) }
  end
end
