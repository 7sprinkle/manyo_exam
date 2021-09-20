User.create!(name: "yuuki", email: "karakusa168@gmail.com", password: "password", password_confirmation: "password" )
9.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "password"
  password_confirmation = "password"
  User.create!(name: name, email: email, password: password, password_confirmation: password_confirmation )
end
