class AddGroupMembersJob < ApplicationJob
  queue_as :add_group_members

  def perform(new_members_emails, group)
    email_array = new_members_emails.split(',')
    email_array.each do |email|
      clean_email = email.strip
      member = Member.find_by_email(clean_email)
      GroupMember.create(group: group, member: member)
    end
  end
end
