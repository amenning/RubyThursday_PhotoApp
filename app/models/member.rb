class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :albums
  has_many :groups
  has_many :group_members
  has_many :group_memberships, class_name: 'Group', through: :group_members
end
