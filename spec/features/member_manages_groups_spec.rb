require 'rails_helper'

feature 'member manages groups' do
  let!(:member) { FactoryGirl.create(:member) }
  let!(:member2) { FactoryGirl.create(:member, first_name: 'Todd', last_name: 'Wahnish') }

  scenario 'by creating a new group', js: true do
    login_as(member, scope: :member)
    visit root_path
    click_link 'Dashboard'
    expect(page).to have_content 'My Dashboard'

    click_link 'Create New Group'
    expect(page).to have_content 'Create A New Group!'

    fill_in 'group[name]', with: 'The Wahnishes'
    select 'Todd'
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

    group_member = GroupMember.last
    expect(group_member).to have_attributes(
      group_id: group.id,
      member_id: member2.id
    )
  end
end
