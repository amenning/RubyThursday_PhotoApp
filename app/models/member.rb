class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :albums
  has_many :groups
  has_many :group_members
  has_many :group_memberships, class_name: 'Group', through: :group_members

  def groups_followed
    Group.joins(:group_members)
      .merge(GroupMember.where(member_id: id))
  end

  def albums_followed
    Album.joins(:album_groups)
      .merge(AlbumGroup.where(group_id: groups_followed))
  end

  def following_album?(album)
    albums = albums_followed
    albums.include?(album)
  end
end
