# Base policy class
class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  private

  def developer?
    if @user
      @user.developer?
    end
  end

  def admin?
    if @user
      @user.admin?
    end
  end
end
