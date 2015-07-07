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

  def sync_repos?
    admin? || developer?
  end
end
