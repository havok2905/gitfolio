# Profiles Controller Permissions
class ProfilePolicy < ApplicationPolicy
  def index?
    admin?
  end

  def show?
    true
  end

  def new?
    (developer? && has_no_profile?) || admin?
  end

  def create?
    (developer? && has_no_profile?) || admin?
  end

  def edit?
    developer? || admin?
  end

  def update?
    developer? || admin?
  end

  private

  def no_profile?
    @user.profile.nil?
  end
end
