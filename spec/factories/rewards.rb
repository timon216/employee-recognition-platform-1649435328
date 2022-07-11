FactoryBot.define do
  factory :reward do
    sequence(:title) { |i| "Reward Title #{i}" }
    sequence(:description) { |i| "Reward Description #{i}" }
    price { '1.00' }
  end
end
