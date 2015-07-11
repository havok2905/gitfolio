# Controller for User tailored profile pages for the public
class ProfilesController < ApplicationController

  helper_method :profile, :profiles, :user_repos

  before_action :authenticate_user!, except: [:show]
  before_action { authorize :profile }

  def create
    if profile.save
      update_whitelist
      setup_developer_profile
      redirect_to profile_url(profile)
    else
      redirect_to new_profile_url
    end
  end

  def update
    if profile.update_attributes profile_params
      update_whitelist
      redirect_to profile_url(profile)
    else
      redirect_to edit_profile_url(profile)
    end
  end

  private

  def profile_params
    params.require(:profile).permit([
      :first_name,
      :last_name,
      :email,
      :tagline,
      :position
    ])
  end

  def profile
    @profile ||= load_profile
  end

  def profiles
    Profile.order(:id)
  end

  def load_profile
    blank || found || created || view_model
  end

  def blank
    %w(new).include?(params[:action]) && Profile.new
  end

  def found
    %w(edit update).include?(params[:action]) && Profile.find(params[:id])
  end

  def created
    %w(create).include?(params[:action]) && Profile.new(profile_params)
  end

  def view_model
    %w(show).include?(params[:action]) && Profile.find(params[:id]).view_model
  end

  def update_whitelist
    return unless current_user.developer?
    Repo.update_whitelist(current_user, selected_repos)
  end

  def setup_developer_profile
    return unless current_user.developer?
    current_user.update_attributes profile: profile
  end

  def user_repos
    profile.user_repos
  end

  def selected_repos
    params['repo_ids']
  end
end
