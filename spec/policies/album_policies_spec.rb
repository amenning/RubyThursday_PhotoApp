require 'rails_helper'

describe AlbumPolicy do
  subject { described_class }
  context 'for a visitor' do
    let(:member) { nil }
    let(:album) { FactoryGirl.create(:album) }
    permissions :index?, :show?, :new?, :edit?, :create?, :update?, :destroy? do
      it 'does not grant access for non logged in visitors' do
        expect(subject).not_to permit(member, album)
      end
    end
  end

  context 'for member creating an album' do
    let(:member) { FactoryGirl.create(:member) }
    permissions :new?, :create? do
      it 'grants access to member' do
        expect(subject).to permit(member)
      end
    end
  end

  context 'for member trying to edit or destroy album he/she did not create' do
    let(:album) { FactoryGirl.create(:album) }
    let(:member) { FactoryGirl.create(:member) }
    permissions :edit?, :update?, :destroy? do
      it 'denies access to member for whom the album does not belong' do
        expect(subject).not_to permit(member, album)
      end
    end
  end

  context 'for member editing own album' do
    let(:member) { FactoryGirl.create(:member) }
    permissions :edit?, :update?, :destroy? do
      it 'grants access if album belongs to member' do
        expect(subject).to permit(member, Album.create!(member_id: member.id))
      end
    end
  end

  context 'for member viewing album' do
    before do
      image = FactoryGirl.create(:image)
      @album = image.album
      @album_owner = @album.member
      @album_follower = FactoryGirl.create(:member, first_name: 'Album Follower')
      @non_album_follower = FactoryGirl.create(:member, first_name: 'Non Album Follower')
      group = Group.create(name: 'The Wahnishes', member: @album_owner)
      AlbumGroup.create(album: @album, group: group)
      GroupMember.create(member: @album_follower, group: group)
    end

    permissions :show? do
      it 'denies access to member not following album' do
        expect(subject).not_to permit(@non_album_follower, @album)
      end

      it 'grants access to member following album' do
        expect(subject).to permit(@album_follower, @album)
      end

      it 'grants access to album owner' do
        expect(subject).to permit(@album_owner, @album)
      end
    end
  end
end
