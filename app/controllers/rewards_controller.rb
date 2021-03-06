class RewardsController < ApplicationController
  before_action :authenticate_employee!

  def index
    @rewards = Reward.all
  end

  def show
    reward
  end

  private

  def reward
    @reward ||= Reward.find(params[:id])
  end

  def reward_params
    params.require(:reward).permit(:title, :description, :price)
  end
end
