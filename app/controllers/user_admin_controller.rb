class UserAdminController < ApplicationController

  helper_method :users

  before_action :authenticate_user!
  before_action { authorize :user }

  def index
  end

  private

  def users
    User.order(:id)
  end
end
