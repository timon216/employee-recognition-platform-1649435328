module Accessible
  extend ActiveSupport::Concern
  included do
    before_action :check_user
  end

  protected

  def check_user
    if current_admin_user
      flash.clear
      set_flash_message! :notice, :signed_in
      # if you have rails_admin. You can redirect anywhere really
      redirect_to(admin_pages_dashboard_path) and return
    elsif current_employee
      flash.clear
      set_flash_message! :notice, :signed_in
      # The authenticated root path can be defined in your routes.rb in: devise_scope :user do...
      redirect_to(kudos_path) and return
    end
  end
end
