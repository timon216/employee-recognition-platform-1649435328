module AdminUsers
  class EmployeesController < ApplicationController
    before_action :set_employee, only: %i[show edit update destroy]
    before_action :authenticate_admin_user!

    # GET /admin_users/employees
    def index
      @employees = Employee.all
    end

    # GET /admin_users/employees/1
    def show; end

    # GET /admin_users/employees/1/edit
    def edit; end

    # PATCH/PUT /admin_users/employees/1
    def update
      if employee_params[:password].blank?
        render :edit unless @employee.update(employee_params.except(:password))
        redirect_to admin_users_employees_path, notice: 'Employee was successfully updated.'
      elsif @employee.update(employee_params)
        redirect_to admin_users_employees_path, notice: 'Employee was successfully updated.'
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
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def employee_params
      params.require(:employee).permit(:email, :password, :number_of_available_kudos)
    end
  end
end
