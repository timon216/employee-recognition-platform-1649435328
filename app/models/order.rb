class Order < ApplicationRecord
  serialize :reward_snapshot

  belongs_to :employee
  belongs_to :reward

  def snapshot_price
    reward_snapshot.price
  end
end
