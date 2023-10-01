# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

admin_password = Rails.application.credentials.dig(:all_environments, :admin, :password)

User.create!(
  email: 'diegoyon@outlook.com',
  password: admin_password,
  password_confirmation: admin_password
)
