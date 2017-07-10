require 'rails_helper'

RSpec.describe AlbumGroup, type: :model do
  describe 'associations' do
    it { should belong_to(:album) }
    it { should belong_to(:group) }
  end
end
