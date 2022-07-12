class OrdersController < ApplicationController
  before_action :authenticate_employee!

  def index 
    @orders = Order.where(employee: current_employee)
  end

  def create
    if current_employee.earned_points < reward.price
      redirect_to rewards_path, notice: "You don't have enough points to buy this reward"
    else
      order = Order.new(employee: current_employee, reward: reward, reward_snapshot: reward)
      order.save
      redirect_to rewards_path, notice: 'You have bought a new reward'
    end
  end

  private

  def reward
    Reward.find(params[:reward])
  end
end
