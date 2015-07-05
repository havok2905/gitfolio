require 'rails_helper'
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
