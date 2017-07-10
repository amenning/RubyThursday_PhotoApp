class GroupMember < ApplicationRecord
  belongs_to :member
  belongs_to :group, optional: true
end
