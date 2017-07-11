require 'rails_helper'

feature 'member manages groups' do
  let!(:member) { FactoryGirl.create(:member) }
  let!(:member2) { FactoryGirl.create(:member, first_name: 'Todd', last_name: 'Wahnish') }

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

  scenario 'by creating a new group and inviting a non-member' do
    login_as(member, scope: :member)
    visit root_path
    click_link 'Dashboard'
    expect(page).to have_content 'My Dashboard'

    click_link 'Create New Group'
    expect(page).to have_content 'Create A New Group!'

    fill_in 'group[name]', with: 'The Wahnishes'
    fill_in 'new_member_email', with: 'melissa@rubythursday.com'
    click_button 'Create group'
    expect(page).to have_content 'Group was successfully created.'
    expect(page).to have_content 'The Wahnishes'
    expect(Group.count).to eq 1
    expect(GroupMember.count).to eq 1

    group = Group.last
    expect(group).to have_attributes(
      name: 'The Wahnishes',
      member_id: member.id
    )

    new_member = Member.last
    expect(new_member.email).to eq 'melissa@rubythursday.com'
    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end
end
