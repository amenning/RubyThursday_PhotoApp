require 'rails_helper'

feature 'member manages groups' do
  let(:member) { FactoryGirl.create(:member) }

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
    expect(Group.count).to eq 1
    group = Group.last
    expect(group).to have_attributes(
      name: 'The Wahnishes',
      member_id: member.id
    )
  end
end
