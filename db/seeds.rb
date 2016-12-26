# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
include Faker

10.times do
  user = User.create!(
  name: Faker::Name.name,
  email: Faker::Internet.email,
  password: Faker::Internet.password
  )
end

# user_1 = User.create!(
#   name: "Anthony",
#   email: "newemail@blocipedia.com",
#   password: "password"
# )
# user_1.skip_confirmation!
# user_1.save!

users = User.all

20.times do
    Wiki.create!(
    user: users.sample,
    title: Faker::Hipster.sentence,
    body: Faker::Hipster.paragraph
  )
end

puts "Seeds finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
