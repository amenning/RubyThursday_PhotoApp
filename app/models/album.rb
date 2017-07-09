class Album < ApplicationRecord
  belongs_to :member
  has_many :images
end
