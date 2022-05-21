# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

1.upto(5) do |t|
    # Employee.create!(email: "employee#{t}@test.com", password: "password")
    Employee.where(email: "employee#{t}@test.com").first_or_create!(password: "password")
end

CompanyValue.where(title: "Honesty").first_or_create!
CompanyValue.where(title: "Ownership").first_or_create!
CompanyValue.where(title: "Accountability").first_or_create!
CompanyValue.where(title: "Passion").first_or_create!

1.upto(4) do |t|
    Kudo.create!(title: "title", content: "very nice kudo #{t}", giver: Employee.find_by(email: "employee#{t}@test.com"), receiver: Employee.find_by(email: "employee#{t+1}@test.com"), company_value: CompanyValue.all.sample)
end

1.upto(2) do |t|
    # AdminUser.create!(email: "admin#{t}@test.com", password: "qwerty")
    AdminUser.where(email: "admin#{t}@test.com").first_or_create!(password: "qwerty")
end
