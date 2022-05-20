module AdminUsers
  class CompanyValuesController < ApplicationController
    before_action :authenticate_admin_user!

    def index
      @company_values = CompanyValue.all
    end

    def show
      company_value
    end

    def new
      @company_value = CompanyValue.new
    end

    def edit
      company_value
    end

    def create
      @company_value = CompanyValue.new(company_value_params)

      if @company_value.save
        redirect_to admin_users_company_values_path, notice: 'Company value was successfully created.'
      else
        render :new
      end
    end

    def update
      if company_value.update(company_value_params)
        redirect_to admin_users_company_values_path, notice: 'Company value was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      company_value.destroy
      redirect_to admin_users_company_values_path, notice: 'Company value was successfully destroyed.'
    end

    private

    def company_value
      @company_value = CompanyValue.find(params[:id])
    end

    def company_value_params
      params.require(:company_value).permit(:title)
    end
  end
end
