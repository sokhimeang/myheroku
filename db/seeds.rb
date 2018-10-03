# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

1000.times do |n|
  name  = Faker::Name.name
  code  = Faker::Code.nric
  email = "example-#{n+1}@railstutorial.org"
  info = "#{name},#{code},#{email}"
  password = "password"
  User.create!(code:  code,
               name: name,
               email: email,
               info: info ,
               password_digest: password,
               admin: false
               )
end

30.times do |n|
  name  = "ruby on rails #{n}"
  code  = "IT#{n}"
  Subject.create!(code:  code,
               name: name,
               times_exam: 90
               )
end

10.times do |n|
  name  = "room #{n}"
  code  = "A#{n}"
  Room.create!(code:  code,
               name: name,
               volume: 20,
               overseer_number: 2,
               state: true
               )
end

subjects = Subject.all
users = User.all

subjects.each do |s|
  rand(30..50).times do |n|
  user = users[rand(0...1000)]
  unless s.was_exist?(user)
  s.add_student user
  end
  end
end

