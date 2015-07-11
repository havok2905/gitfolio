# Welcome page controller for the site
class IndexController < ApplicationController
  before_action :authenticate_user!
end
