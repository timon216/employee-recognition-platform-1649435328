class KudosController < ApplicationController
  before_action :authenticate_employee!

  def index
    @kudos = Kudo.all
  end

  def show
    kudo
  end

  def new
    @kudo = current_employee.given_kudos.build
  end

  def edit
    kudo
    correct_employee
  end

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

  def update
    correct_employee
    if kudo.update(kudo_params)
      redirect_to @kudo, notice: 'Kudo was successfully updated.'
    else
      render :edit
    end
  end

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

  def kudo
    @kudo = Kudo.find(params[:id])
  end

  def kudo_params
    params.require(:kudo).permit(:title, :content, :giver_id, :receiver_id)
  end
end
