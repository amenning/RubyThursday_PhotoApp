require 'rails_helper'

RSpec.describe Member, type: :model do
  describe 'associations' do
    it { should have_many(:albums) }
  end
end
