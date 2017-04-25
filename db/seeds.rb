# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!( name:  "Admin",
  email: "admin@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  number_of_phone: "0969304641",
  role: 0
)

User.create!( name:  "Teacher",
  email: "teacher@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  number_of_phone: "0969304641",
  role: 1
)

User.create!( name:  "Student",
  email: "student@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  number_of_phone: "0969304641",
  role: 2
)

Category.create!(name: "Ngoại ngữ",
  types_attributes: [{name: "Tiếng Anh"}, {name: "Tiếng Nhật"}, {name: "Tiếng Hàn"}, {name: "Tiếng Trung"}]
)

Category.create!(name: "Ngôn ngữ lập trình",
  types_attributes: [{name: "C ++"}, {name: "JAVA"}, {name: "PHP"}, {name: "RUBY"}, {name: ".NET"}]
)

