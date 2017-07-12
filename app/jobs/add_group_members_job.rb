class AddGroupMembersJob < ApplicationJob
  queue_as :add_group_members

  def perform(new_members_emails, group)
    email_array = new_members_emails.split(',')
    email_array.each do |email|
      clean_email = email.strip
      member = Member.find_by_email(clean_email)
      if member.nil?
        member = Member.create!(
          email: clean_email,
          password: '123123123',
          password_confirmation: '123123123'
        )
        member.invite!
      end
      GroupMember.create(group: group, member: member)
    end
  end
end
