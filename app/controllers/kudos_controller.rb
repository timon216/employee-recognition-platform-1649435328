class KudosController < ApplicationController
  before_action :set_kudo, only: %i[show edit update destroy]
  before_action :authenticate_employee!
  before_action :correct_employee, only: %i[edit update destroy]

  # GET /kudos
  def index
    @kudos = Kudo.all
  end

  # GET /kudos/1
  def show; end

  # GET /kudos/new
  def new
    @kudo = current_employee.given_kudos.build
  end

  # GET /kudos/1/edit
  def edit; end

  # POST /kudos
  def create
    if current_employee.number_of_available_kudos < 1 
      redirect_to kudos_path, notice: "You don't have any available kudo to give"
    else
      @kudo = current_employee.given_kudos.build(kudo_params)
      @kudo.giver = current_employee
    
      if @kudo.save
        redirect_to kudos_path, notice: 'Kudo was successfully created.'

        current_employee.update(number_of_available_kudos: current_employee.number_of_available_kudos - 1)
      else
        render :new
      end
    end
  end

  # PATCH/PUT /kudos/1
  def update
    if @kudo.update(kudo_params)
      redirect_to @kudo, notice: 'Kudo was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /kudos/1
  def destroy
    @kudo.destroy
    redirect_to kudos_url, notice: 'Kudo was successfully destroyed.'

    if current_employee.number_of_available_kudos < 10
      current_employee.update(number_of_available_kudos: current_employee.number_of_available_kudos + 1)
    end
  end

  def correct_employee
    @kudo = current_employee.given_kudos.find_by(id: params[:id])
    redirect_to kudos_path, notice: 'Not Authorized to Edit This Kudo' if @kudo.nil?
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_kudo
    @kudo = Kudo.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def kudo_params
    params.require(:kudo).permit(:title, :content, :giver_id, :receiver_id)
  end
end
