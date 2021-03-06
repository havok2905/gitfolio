# Profiles Controller Permissions
class ProfilePolicy < ApplicationPolicy
  def index?
    admin?
  end

  def show?
    @record.published? || current_users? || admin?
  end

  def new?
    (developer? && no_profile?) || admin?
  end

  def create?
    (developer? && no_profile?) || admin?
  end

  def edit?
    current_users? || admin?
  end

  def update?
    current_users? || admin?
  end

  def publish?
    current_users? || admin?
  end

  def deactivate?
    current_users? || admin?
  end

  def launch?
    developer? || admin?
  end

  private

  def no_profile?
    @user.profile_id.nil?
  end
end
