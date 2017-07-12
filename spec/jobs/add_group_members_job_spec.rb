require 'rails_helper'

RSpec.describe AddGroupMembersJob, type: :job do
  let!(:member2) do
    FactoryGirl.create(
      :member,
      first_name: 'Todd',
      last_name: 'Wahnish',
      email: 'todd@rubythursday.com'
    )
  end
  let!(:group) { FactoryGirl.create(:group) }
  describe 'for existing member' do
    it 'creates group membership association' do
      new_members_emails = 'todd@rubythursday.com'
      expect { AddGroupMembersJob.perform_now(new_members_emails, group) }
        .to change { GroupMember.count }.from(0).to(1)
    end
  end

  # describe 'for non members' do
  #   it 'creates member' do
  #
  #   end
  #
  #   it 'sends invitation' do
  #
  #   end
  #
  #   it 'creates group membership associations' do
  #
  #   end
  # end
end
