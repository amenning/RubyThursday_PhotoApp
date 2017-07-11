require 'rails_helper'

feature 'member manages groups' do
  let!(:member) { FactoryGirl.create(:member) }
  let!(:member2) do
    FactoryGirl.create(
      :member,
      first_name: 'Todd',
      last_name: 'Wahnish',
      email: 'todd@rubythursday.com'
    )
  end

  scenario 'by creating a new group' do
    login_as(member, scope: :member)
    visit root_path
    click_link 'Dashboard'
    expect(page).to have_content 'My Dashboard'

    click_link 'Create New Group'
    expect(page).to have_content 'Create A New Group!'

    fill_in 'group[name]', with: 'The Wahnishes'
    click_button 'Create group'
    expect(page).to have_content 'Group was successfully created.'
    expect(page).to have_content 'The Wahnishes'
    expect(page).to have_content 'Add Members'
    expect(Group.count).to eq 1

    group = Group.last
    expect(group).to have_attributes(
      name: 'The Wahnishes',
      member_id: member.id
    )
  end

  scenario 'by adding members' do
    group = FactoryGirl.create(:group, member: member)
    login_as(member, scope: :member)
    visit group_path(group)
    expect(page).to have_content group.name
    expect(page).to have_content 'Add Members'

    fill_in 'new_members_emails', with: 'melissa@rubythursday.com, todd@rubythursday.com'
    click_button 'Add New Group Members'
    expect(page).to have_content 'Members will be added to this group. Invitations were sent to new members.'
    expect(page).to have_content group.name
    expect(ActiveJob::Base.queue_adapter.enqueued_jobs.size).to eq 1
  end
end
