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

  describe '#groups_followed' do
    it 'returns all the groups a member follows' do
      group_owner = FactoryGirl.create(:member, first_name: 'Group Owner')
      group_follower = FactoryGirl.create(:member, first_name: 'Group Follower')
      group = Group.create(name: 'The Wahnishes', member: group_owner)
      GroupMember.create(member: group_follower, group: group)

      results = group_follower.groups_followed
      expect(results).to include group
    end

    it 'returns only the groups a member follows' do
      group_owner = FactoryGirl.create(:member, first_name: 'Group Owner')
      non_group_follower = FactoryGirl.create(:member, first_name: 'Non Group Follower')
      group = Group.create(name: 'The Wahnishes', member: group_owner)

      results = non_group_follower.groups_followed
      expect(results).to_not include group
    end
  end

  describe '#albums_followed' do
    it 'returns all the albums a member follows' do
      image = FactoryGirl.create(:image)
      album = image.album
      album_owner = album.member
      album_follower = FactoryGirl.create(:member)
      group = Group.create(name: 'The Wahnishes', member: album_owner)
      AlbumGroup.create(album: album, group: group)
      GroupMember.create(member: album_follower, group: group)

      results = album_follower.albums_followed
      expect(results).to include album
    end

    it 'returns only the albums a member follows' do
      image = FactoryGirl.create(:image)
      album = image.album
      album_owner = album.member
      non_album_follower = FactoryGirl.create(:member)
      group = Group.create(name: 'The Wahnishes', member: album_owner)
      AlbumGroup.create(album: album, group: group)

      results = non_album_follower.albums_followed
      expect(results).to_not include album
    end
  end
end
