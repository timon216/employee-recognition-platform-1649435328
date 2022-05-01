module AdminUsers
  class AdminUsers::EmployeesController < ApplicationController
    before_action :set_admin_users_employee, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_admin_user!

    # GET /admin_users/employees
    def index
      @admin_users_employees = AdminUsers::Employee.all
    end

    # GET /admin_users/employees/1
    def show
    end

    # GET /admin_users/employees/new
    def new
      @admin_users_employee = AdminUsers::Employee.new
    end

    # GET /admin_users/employees/1/edit
    def edit
    end

    # POST /admin_users/employees
    def create
      @admin_users_employee = AdminUsers::Employee.new(admin_users_employee_params)

      if @admin_users_employee.save
        redirect_to @admin_users_employee, notice: 'Employee was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /admin_users/employees/1
    def update
      if @admin_users_employee.update(admin_users_employee_params)
        redirect_to @admin_users_employee, notice: 'Employee was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /admin_users/employees/1
    def destroy
      @admin_users_employee.destroy
      redirect_to admin_users_employees_url, notice: 'Employee was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_admin_users_employee
        @admin_users_employee = AdminUsers::Employee.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def admin_users_employee_params
        params.fetch(:admin_users_employee, {})
      end
  end
end