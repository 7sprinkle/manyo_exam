User.create!(name: "yuuki", email: "karakusa168@gmail.com", password: "password", password_confirmation: "password", admin: true )
9.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "password"
  password_confirmation = "password"
  User.create!(name: name, email: email, password: password, password_confirmation: password_confirmation, admin: false )
end

10.times do |n|
  user_id = n + 1
  Task.create!(
    title: "task#{n + 1}",
    content: "content#{n + 1}",
    expired_at: "2021-08-22 00:00:00",
    status: "未着手",
    priority: "低",
    user_id: user_id
  )
end