require 'rails_helper'

# mixin module for logging users in with Devise
module Loginable
  def login_developer
    @developer = create :developer
    sign_in @developer
  end

  def login_admin
    @admin = create :admin
    sign_in @admin
  end
end
