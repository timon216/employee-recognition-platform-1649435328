module Admins
  class OrdersController < AdminController
    before_action :authenticate_admin!

    def index
      @orders = Order.includes(:employee).all
    end

    private

    def employee
      @employee ||= Employee.find(params[:employee_id])
    end
  end
end
