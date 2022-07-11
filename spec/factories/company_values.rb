FactoryBot.define do
  factory :company_value do
    sequence(:title) { |i| "Company Value Title #{i}" }
  end
end
