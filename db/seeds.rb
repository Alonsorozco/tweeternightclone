# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
  User.create([{
   username: Faker::Games::Zelda.character,
          url_photo: Faker::Avatar.image, 
          email: "kztempus@gmail.com",
          password: "123123",
          password_confirmation: "123123",
      },{
          username: Faker::Games::Zelda.character,
          url_photo: Faker::Avatar.image, 
          email: "asdasd@gmail.com",
          password: "123123",
          password_confirmation: "123123",
      },{
          username: Faker::Games::Zelda.character,
          url_photo: Faker::Avatar.image,        
          email: "fabi@gmail.com",
          password: "123123",
          password_confirmation: "123123",
      },{
          username: Faker::Games::Zelda.character,
          url_photo: Faker::Avatar.image, 
          email: "alonso@gmail.com",       password: "123123",
          password_confirmation: "123123",
      }])
         50.times do
             Tweet.create(
                 content: Faker::Games::Zelda.item, 
                 user_id: Random.rand(1..4)
          )
         end
#AdminUser.create!(email: 'admin@example.com', password: '123456', password_confirmation: '123456') if Rails.env.development?