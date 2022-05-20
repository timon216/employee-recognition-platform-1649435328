module AdminUsers
  class EmployeesController < ApplicationController
    before_action :authenticate_admin_user!

    def index
      @employees = Employee.all
    end

    def show
      employee
    end

    def edit
      employee
    end

    def update
      employee
      if employee_params[:password].blank?
        render :edit unless @employee.update(employee_params.except(:password))
        redirect_to admin_users_employees_path, notice: 'Employee was successfully updated.'
      elsif @employee.update(employee_params)
        redirect_to admin_users_employees_path, notice: 'Employee was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      employee.destroy
      redirect_to admin_users_employees_url, notice: 'Employee was successfully destroyed.'
    end

    private

    def employee
      @employee ||= Employee.find(params[:id])
    end

    def employee_params
      params.require(:employee).permit(:email, :password, :number_of_available_kudos)
    end
  end
end
