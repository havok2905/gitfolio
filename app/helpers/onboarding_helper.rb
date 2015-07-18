module OnboardingHelper
  def can_sync?
    current_user.developer?
  end

  def can_build?
    current_user.developer? && current_user.repos.count > 0 && current_user.profile.nil?
  end

  def can_edit?
    current_user.developer? && current_user.repos.count > 0 && current_user.profile.present?
  end
end
