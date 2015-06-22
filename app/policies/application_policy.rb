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
end
