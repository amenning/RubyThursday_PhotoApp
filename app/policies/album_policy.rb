class AlbumPolicy < ApplicationPolicy
  def index?
    @member
  end

  def show?
    @member && @member.albums.include?(@record) || @member && @member.following_album?(@record)
  end

  def new?
    @member
  end

  def create?
    @member
  end

  def update?
    @member && @member.albums.include?(@record) 
  end

  def edit?
    @member && @member.albums.include?(@record)
  end

  def destroy?
    @member && @member.albums.include?(@record)
  end
end
