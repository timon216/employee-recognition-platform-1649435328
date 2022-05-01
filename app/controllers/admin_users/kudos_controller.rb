module AdminUsers
  class KudosController < AdminUserController
    before_action :set_kudo, only: %i[show destroy]
    before_action :authenticate_admin_user!

    # GET /admin_users/kudos
    def index
      @kudos = Kudo.all
    end

    # GET /admin_users/kudos/1
    def show; end

    # DELETE /admin_users/kudos/1
    def destroy
      @kudo = Kudo.find(params[:id])

      return if @kudo.blank?

      @kudo.destroy
      redirect_to admin_users_kudos_url, notice: 'Kudo was successfully destroyed.'
      return unless @kudo.giver.number_of_available_kudos < 10

      @kudo.giver.update(number_of_available_kudos: @kudo.giver.number_of_available_kudos + 1)
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
end
