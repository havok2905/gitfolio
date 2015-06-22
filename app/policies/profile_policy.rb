# Profiles Controller Permissions
class ProfilePolicy < ApplicationPolicy
  def index?
    admin?
  end

  def show?
    true
  end

  def new?
    (developer? && no_profile?) || admin?
  end

  def create?
    (developer? && no_profile?) || admin?
  end

  def edit?
    developer? || admin?
  end

  def update?
    developer? || admin?
  end

  private

  def no_profile?
    @user.profile_id.nil?
  end
end
