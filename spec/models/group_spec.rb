require 'rails_helper'

RSpec.describe Group, type: :model do
  describe 'associations' do
    it { should belong_to(:member) }
    it { should have_many(:group_memberships).class_name('Member').through(:group_members) }
  end
end
