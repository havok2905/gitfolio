# Profiles Controller Permissions
class UserPolicy < ApplicationPolicy
  def index?
    admin?
  end
end
