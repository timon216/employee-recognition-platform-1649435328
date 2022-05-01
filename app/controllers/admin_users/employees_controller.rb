module AdminUsers
  class EmployeesController < ApplicationController
    before_action :set_admin_users_employee, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_admin_user!

    # GET /admin_users/employees
    def index
      @employees = Employee.all
    end

    # GET /admin_users/employees/1
    def show
    end

    # GET /admin_users/employees/new
    def new
      @employee = Employee.new
    end

    # GET /admin_users/employees/1/edit
    def edit
    end

    # POST /admin_users/employees
    def create
      @employee = Employee.new(admin_users_employee_params)

      if @employee.save
        redirect_to @employee, notice: 'Employee was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /admin_users/employees/1
    def update
      if @employee.update(admin_users_employee_params)
        redirect_to @employee, notice: 'Employee was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /admin_users/employees/1
    def destroy
      @employee.destroy
      redirect_to admin_users_employees_url, notice: 'Employee was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_admin_users_employee
        @employee = Employee.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def admin_users_employee_params
        params.fetch(:admin_users_employee, {})
      end
  end
end