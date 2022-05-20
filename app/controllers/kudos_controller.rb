class KudosController < ApplicationController
  before_action :authenticate_employee!

  # GET /kudos
  def index
    @kudos = Kudo.all
  end

  # GET /kudos/1
  def show
    kudo
  end

  # GET /kudos/new
  def new
    @kudo = current_employee.given_kudos.build
  end

  # GET /kudos/1/edit
  def edit
    kudo
    correct_employee
  end

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
    correct_employee
    if kudo.update(kudo_params)
      redirect_to @kudo, notice: 'Kudo was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /kudos/1
  def destroy
    correct_employee
    kudo.destroy
    redirect_to kudos_url, notice: 'Kudo was successfully destroyed.'

    return unless current_employee.number_of_available_kudos < 10

    current_employee.update(number_of_available_kudos: current_employee.number_of_available_kudos + 1)
  end

  def correct_employee
    @kudo = current_employee.given_kudos.find_by(id: params[:id])
    redirect_to kudos_path, notice: 'Not Authorized to Edit This Kudo' if @kudo.nil?
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def kudo
    @kudo = Kudo.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def kudo_params
    params.require(:kudo).permit(:title, :content, :giver_id, :receiver_id)
  end
end
