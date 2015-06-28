# Profiles Controller Permissions
class UserPolicy < ApplicationPolicy
  def index?
    admin?
  end

  def edit?
    admin?
  end

  def update?
    admin?
  end

  def show?
    admin?
  end
end
