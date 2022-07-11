FactoryBot.define do
  factory :kudo do
    sequence(:title) { |i| "Kudo Title #{i}" }
    sequence(:content) { |i| "Kudo Content #{i}" }
    giver
    receiver
    company_value
  end
end
