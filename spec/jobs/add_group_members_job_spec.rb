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

  describe 'for non members' do
    before do
      ActionMailer::Base.deliveries = []
    end
    it 'creates member' do
      new_members_emails = 'melissa@rubythursday.com'
      expect { AddGroupMembersJob.perform_now(new_members_emails, group) }
        .to change { Member.count }.by(1)

      member = Member.last
      expect(member.email).to eq 'melissa@rubythursday.com'
    end

    it 'sends invitation' do
      new_members_emails = 'melissa@rubythursday.com'
      AddGroupMembersJob.perform_now(new_members_emails, group)
      member = Member.find_by_email('melissa@rubythursday.com')
      expect(member.invitation_token).not_to eq nil
      expect(ActionMailer::Base.deliveries.count).to eq 1
    end

    it 'creates group membership associations' do
      new_members_emails = 'melissa@rubythursday.com'
      expect { AddGroupMembersJob.perform_now(new_members_emails, group) }
        .to change { GroupMember.count }.from(0).to(1)
    end
  end
end
