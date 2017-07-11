class GroupsController < ApplicationController
  def add_group_members
    @group = Group.find(params[:id])
    AddGroupMembersJob.perform_later(params[:new_members_emails], @group)
    redirect_to @group, notice: 'Members will be added to this group. Invitations were sent to new members.'
  end

  def new
    @group = current_member.groups.new
    1.times { @group.group_members.build }
  end

  def create
    @group = current_member.groups.create(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @group = Group.find(params[:id])
  end

  private

  def group_params
    params.require(:group).permit(
      :name,
      :member_id,
      group_members_attributes: [:member_id, :group_id]
    )
  end
end
