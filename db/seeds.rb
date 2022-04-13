# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

1.upto(5) do |t|
    Employee.create!(email: "employee#{t}@test.com", password: "password")
end

Kudo.create!(title: "from console", content: "description", giver: Employee.find_by(email: 'employee1@test.com'), receiver: Employee.find_by(email: 'employee2@test.com'))
