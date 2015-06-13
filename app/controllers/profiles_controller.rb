# Controller for User tailored profile pages for the public
class ProfilesController < ApplicationController

  helper_method :profile

  def create
    if profile.save
      redirect_to profile_url(profile)
    else
      redirect_to new_profile_url
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :email, :tagline, :position)
  end

  def profile
    @profile ||= load_profile
  end

  def load_profile
    found || blank || created
  end

  def found
    params[:action] == 'show' && Profile.find(params[:id])
  end

  def blank
    params[:action] == 'new' && Profile.new
  end

  def created
    params[:action] == 'create' && Profile.new(profile_params)
  end

end
