require 'rails_helper'

RSpec.describe GroupMember, type: :model do
  describe 'associations' do
    it { should belong_to(:member) }
    it { should belong_to(:group) }
  end
end
