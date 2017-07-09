require 'rails_helper'

RSpec.describe Album, type: :model do
  describe 'associations' do
    it { should belong_to(:member) }
    it { should have_many(:images) }
  end
end
