module Admins
  class KudosController < AdminController
    before_action :authenticate_admin!

    def index
      @kudos = Kudo.includes(%i[giver receiver company_value]).all
    end

    def show
      kudo
    end

    def destroy
      kudo
      return if @kudo.blank?

      @kudo.destroy
      redirect_to admins_kudos_path, notice: 'Kudo was successfully destroyed.'
      return unless @kudo.giver.number_of_available_kudos < 10

      @kudo.giver.update(number_of_available_kudos: @kudo.giver.number_of_available_kudos + 1)
    end

    private

    def kudo
      @kudo ||= Kudo.find(params[:id])
    end

    def kudo_params
      params.require(:kudo).permit(:title, :content, :giver_id, :receiver_id, :company_value_id)
    end
  end
end
