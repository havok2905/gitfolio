# Controller for User tailored profile pages for the public
class ProfilesController < ApplicationController

  helper_method :profile, :profiles, :user_repos

  before_action :authenticate_user!, except: [:show]
  before_action { authorize profile }

  def create
    if profile.save
      update_whitelist
      setup_developer_profile
      redirect_to profile_path(profile)
    else
      redirect_to new_profile_path
    end
  end

  def update
    if profile.update_attributes profile_params
      update_whitelist
      redirect_to profile_path(profile)
    else
      redirect_to edit_profile_path(profile)
    end
  end

  def publish
    profile.update_attributes(published: true) && redirect_to(profile_launch_path)
  end

  def deactivate
    profile.update_attributes(published: false) && redirect_to(profile_launch_path)
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
    blank || found || created
  end

  def blank
    %w(new index launch).include?(params[:action]) && Profile.new
  end

  def found
    %w(edit update show publish deactivate).include?(params[:action]) && Profile.find(params[:id])
  end

  def created
    %w(create).include?(params[:action]) && Profile.new(profile_params)
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
