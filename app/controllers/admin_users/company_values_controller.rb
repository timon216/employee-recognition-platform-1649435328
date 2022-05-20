module AdminUsers
  class CompanyValuesController < ApplicationController
    before_action :authenticate_admin_user!

    # GET /admin_users/company_values
    def index
      @company_values = CompanyValue.all
    end

    # GET /admin_users/company_values/1
    def show
      company_value
    end

    # GET /admin_users/company_values/new
    def new
      @company_value = CompanyValue.new
    end

    # GET /admin_users/company_values/1/edit
    def edit
      company_value
    end

    # POST /admin_users/company_values
    def create
      @company_value = CompanyValue.new(company_value_params)

      if @company_value.save
        redirect_to admin_users_company_values_path, notice: 'Company value was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /admin_users/company_values/1
    def update
      if company_value.update(company_value_params)
        redirect_to admin_users_company_values_path, notice: 'Company value was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /admin_users/company_values/1
    def destroy
      company_value.destroy
      redirect_to admin_users_company_values_path, notice: 'Company value was successfully destroyed.'
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def company_value
      @company_value = CompanyValue.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def company_value_params
      params.require(:company_value).permit(:title)
    end
  end
end
