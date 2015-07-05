# Controller for User tailored profile pages for the public
class ProfilesController < ApplicationController

  helper_method :profile, :profiles

  before_action :authenticate_user!, except: [:show]
  before_action { authorize :profile }

  def show
    @repos = profile.user.repos.all
  end

  def create
    if profile.save
      assign_developer_profile
      assign_developer_repos
      redirect_to profile_url(profile)
    else
      redirect_to new_profile_url
    end
  end

  def update
    if profile.update_attributes profile_params
      redirect_to profile_url(profile)
    else
      redirect_to edit_profile_url(profile)
    end
  end

  private

  def api
    @api ||= GithubApi.new
  end

  def assign_developer_profile
    return unless current_user.developer?

    current_user.profile = profile
    current_user.save
  end

  def assign_developer_repos
    return unless current_user.developer?
    repos = api.repo_data username: profile.nickname
    repos.each do |repo|
      assign_developer_repo repo
    end
  end

  def assign_developer_repo(repo)
    return unless current_user.developer?
    profile.repos.push Repo.create(
      url: repo[:url],
      description: repo[:description],
      name: repo[:name],
      user: profile.user
    )
  end

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :email, :tagline, :position)
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

  def found
    %w(show edit update).include?(params[:action]) && Profile.find(params[:id])
  end

  def blank
    params[:action] == 'new' && Profile.new
  end

  def created
    params[:action] == 'create' && Profile.new(profile_params)
  end

end
