# This file should ensure the existence of records required to run the application in
# every environment (production,development, test).
# The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with
# the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
User.create!(username:  "白水 貴太",
            email: "sample@example.com",
            password:              "foobar",
            password_confirmation: "foobar",
            admin: true)

99.times do |n|
 name  = Faker::Name.name
 email = "sample-#{n+1}@example.com"
 password = "password"
 User.create!(username:  name,
              email: email,
              password:              password,
              password_confirmation: password)
end