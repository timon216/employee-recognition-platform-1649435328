FactoryBot.define do
  factory :employee, aliases: %i[receiver giver] do
    sequence(:email) { |i| "test#{i}@test.com" }
    password { 'password' }
  end
end
