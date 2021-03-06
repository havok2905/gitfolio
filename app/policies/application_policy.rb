# Base policy class
class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  private

  def developer?
    @user.developer? if @user
  end

  def admin?
    @user.admin? if @user
  end

  def current_users?
    return false unless @user.present?
    @user.id == @record.user.id
  end
end
