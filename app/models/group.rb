class Group < ApplicationRecord
  belongs_to :member
  has_many :group_members
  has_many :group_memberships, class_name: 'Member', through: :group_members

  accepts_nested_attributes_for :group_members
end
