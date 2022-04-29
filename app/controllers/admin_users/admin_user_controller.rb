# frozen_string_literal: true

module AdminUsers
  class AdminUserController < ApplicationController
    before_action :authenticate_admin_user!

    layout 'admin_user'
  end
end
