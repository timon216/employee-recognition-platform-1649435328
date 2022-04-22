# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # class AuthorizationException < StandardError
  # end

  # rescue_from AuthorizationException do
  #   render text: "Access Denied", status: :unauthorized
  # end

  # protected
  # def authenticate_employee_or_admin_user!
  #   unless employee_signed_in? or admin_user_signed_in?
  #     raise AuthorizationException.new
  #   end
  # end
end
