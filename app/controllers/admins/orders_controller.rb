module Admins
  class OrdersController < AdminController
    before_action :authenticate_admin!

    def index
      @orders = Order.includes(:employee).all
    end
  end
end
