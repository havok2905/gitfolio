# Profiles Controller Permissions
class ProfilePolicy < ApplicationPolicy
  def index?
    admin?
  end

  def show?
    true
  end

  def new?
    developer? || admin?
  end

  def create?
    developer? || admin?
  end

  def edit?
    developer? || admin?
  end

  def update?
    developer? || admin?
  end
end
