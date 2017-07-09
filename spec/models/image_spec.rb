require 'rails_helper'

RSpec.describe Image, type: :model do
  describe 'validations' do
    it 'has a valid factory' do
      expect(FactoryGirl.create(:image)).to be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:album) }
  end
end
