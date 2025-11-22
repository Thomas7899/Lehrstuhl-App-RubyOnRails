# app/controllers/api/base_controller.rb
module Api
  class BaseController < ActionController::API
    skip_before_action :authenticate_user!, raise: false
  end
end
