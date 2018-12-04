require 'faker'

5.times do
  category = Category.create!(title: Faker::Commerce.material)
end

10.times do
  game = Game.offset(rand(Category.count)).first
  game = Game.create!(title: Faker::Name.first_name, description: Faker::Lorem.sentences(4), code: Faker::Code.isbn)
end

10.times do
  user = User.create!(username: Faker::Name.first_name , email: Faker::Internet.email, password: Faker::Internet.password(8))
end

20.times do
  rand_user = User.offset(rand(User.count)).first
  rand_game = Game.offset(rand(Game.count)).first
  copy = Copy.create!(game: rand_game, user: rand_user, available: true, address: Faker::Address.full_address, return: Time.now)
end
