# Controller for User crud opperations
class UserAdminController < ApplicationController

  helper_method :users, :user

  before_action :authenticate_user!
  before_action { authorize :user }

  def update
    if user.update_attributes user_params
      redirect_to user_url(user)
    else
      redirect_to edit_user_url(user)
    end
  end

  def sync_repos
    binding.pry
    user.sync_repos
    redirect_to user_url(user)
  end

  private

  def users
    User.order(:id)
  end

  def user
    @user ||= load_user
  end

  def user_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation,
      :role,
      :provider,
      :uid,
      :nickname
    )
  end

  def load_user
    blank || found || created
  end

  def found
    %w(show edit update sync_repos).include?(params[:action]) && User.find(params[:id])
  end

  def blank
    params[:action] == 'new' && User.new
  end

  def created
    params[:action] == 'create' && User.new(user_params)
  end
end
