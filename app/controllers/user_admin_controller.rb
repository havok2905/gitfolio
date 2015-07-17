# Controller for User crud opperations
class UserAdminController < ApplicationController

  helper_method :users, :user

  before_action :authenticate_user!
  before_action { authorize user }

  def update
    if user.update_attributes user_params
      redirect_to user_path(user)
    else
      redirect_to edit_user_path(user)
    end
  end

  def sync_repos
    user.sync_repos
    redirect_to authenticated_root_path
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
    %w(new index).include?(params[:action]) && User.new
  end

  def created
    %w(create).include?(params[:action]) && User.new(user_params)
  end
end
