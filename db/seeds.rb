require 'faker'

10.times do
  category = Category.create!(title: "dd")
end

10.times do
   game = Game.offset(rand(Category.count)).first
   game = Game.create!(title: Faker::Name.first_name, description: game, code: "1234")
end

10.times do
   user = User.create!(username: Faker::Name.first_name , email: Faker::Internet.email, password: "123456789") 
end

20.times do
   use = User.offset(rand(User.count)).first
   game = Game.offset(rand(Game.count)).first
   copy = Copy.create!(game: game, user: use, available: true, address: Faker::Address.postcode, return: Time.now)
end


# 10.times do
#   username = Username.create!(user: Faker::name.username)
#   user.game_ids = rand(Game.first.id..Game.last.id)
# end

# Copy.all.each do |copy|
#   game.user_ids = rand(User.first.id..User.last.id)
# end