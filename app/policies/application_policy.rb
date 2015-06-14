# Base policy class
class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  private

  def developer?
    @user.developer?
  end

  def admin?
    @user.admin?
  end
end
