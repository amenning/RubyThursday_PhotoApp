class Album < ApplicationRecord
  belongs_to :member
  has_many :images
  has_many :album_groups
  has_many :groups, through: :album_groups

  accepts_nested_attributes_for :album_groups
end
