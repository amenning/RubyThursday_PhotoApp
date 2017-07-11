class ApplicationPolicy
  attr_reader :current_member, :record

  def initialize(current_member, record)
    @member = current_member
    @record = record
  end

  def index?
    false
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(current_member, record.class)
  end

  class Scope
    attr_reader :current_member, :scope

    def initialize(current_member, scope)
      @current_member = current_member
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
