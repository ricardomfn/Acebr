# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "open-uri"
require "date"

League.destroy_all
Request.destroy_all
Match.destroy_all
Message.destroy_all
UserChatroom.destroy_all
Chatroom.destroy_all
User.destroy_all
Membership.destroy_all


user1 = User.new({
  email: "ricardo@gmail.com",
  password: "123456",
  first_name: "Ricardo",
  last_name: "Martins",
  nickname:"Ricardo",
  birth_date: "05/07/1992",
  points: 1500
  })
  avatar1 = URI.open("https://res.cloudinary.com/di7aefgt3/image/upload/v1686689244/130916139_btonix.jpg")
  user1.photo.attach(io: avatar1, filename:"Mon avatar1")
  user1.save!

  # Define the user information
  users_info = [
    { email: "elias@gmail.com", first_name: "Elias", last_name: "", nickname: "Elias", birth_date: "", points: 1500 },
    { email: "marcelo.moura@gmail.com", first_name: "Marcelo", last_name: "Moura", nickname: "Marcelo Moura", birth_date: "", points: 1500 },
    { email: "clarismundo@gmail.com", first_name: "Clarismundo", last_name: "", nickname: "Clarismundo", birth_date: "", points: 1500 },
    { email: "romeu@gmail.com", first_name: "Romeu", last_name: "", nickname: "Romeu", birth_date: "", points: 1500 },
    { email: "junior.lemos@gmail.com", first_name: "Junior", last_name: "Lemos", nickname: "Junior Lemos", birth_date: "", points: 1500 },
    { email: "fred@gmail.com", first_name: "Fred", last_name: "", nickname: "Fred", birth_date: "", points: 1500 },
    { email: "sandro@gmail.com", first_name: "Sandro", last_name: "", nickname: "Sandro", birth_date: "", points: 1500 },
    { email: "paulo.pantusa@gmail.com", first_name: "Paulo", last_name: "Pantusa", nickname: "Paulo Pantusa", birth_date: "", points: 1500 },
    { email: "edinho@gmail.com", first_name: "Edinho", last_name: "", nickname: "Edinho", birth_date: "", points: 1500 },
    { email: "bebetto@gmail.com", first_name: "Bebeto", last_name: "", nickname: "Bebeto", birth_date: "", points: 1500 },
    { email: "filipe@gmail.com", first_name: "Filipe", last_name: "", nickname: "Filipe", birth_date: "", points: 1500 },
    { email: "dudu@gmail.com", first_name: "Dudu", last_name: "", nickname: "Dudu", birth_date: "", points: 1500 },
    { email: "vicente@gmail.com", first_name: "Vicente", last_name: "", nickname: "Vicente", birth_date: "", points: 1500 },
    { email: "rodrigo@gmail.com", first_name: "Rodrigo", last_name: "", nickname: "Rodrigo", birth_date: "", points: 1500 },
    { email: "yuri@gmail.com", first_name: "Yuri", last_name: "", nickname: "Yuri", birth_date: "", points: 1500 },
    { email: "victor@gmail.com", first_name: "Victor", last_name: "", nickname: "Victor", birth_date: "", points: 1500 },
    { email: "lucio@gmail.com", first_name: "Lucio", last_name: "", nickname: "Lucio", birth_date: "", points: 1500 },
    { email: "ricardinho@gmail.com", first_name: "Ricardinho", last_name: "", nickname: "Ricardinho", birth_date: "", points: 1500 },
    { email: "matheus.martins@gmail.com", first_name: "Matheus", last_name: "Martins", nickname: "Matheus Martins", birth_date: "", points: 1500 },
    { email: "tiel@gmail.com", first_name: "Tiel", last_name: "", nickname: "Tiel", birth_date: "", points: 1500 },
    { email: "tony@gmail.com", first_name: "Tony", last_name: "", nickname: "Tony", birth_date: "", points: 1500 },
    { email: "odair@gmail.com", first_name: "Odair", last_name: "", nickname: "Odair", birth_date: "", points: 1500 },
    { email: "gabriel@gmail.com", first_name: "Gabriel", last_name: "", nickname: "Gabriel", birth_date: "", points: 1500 },
    { email: "gleidson@gmail.com", first_name: "Gleidson", last_name: "", nickname: "Gleidson", birth_date: "", points: 1500 },
    { email: "joaovictor@gmail.com", first_name: "Joao Victor", last_name: "", nickname: "Joao Victor", birth_date: "", points: 1500 },
    { email: "carlos@gmail.com", first_name: "Carlos", last_name: "", nickname: "Carlos", birth_date: "", points: 1500 },
    { email: "dudumytsuka@gmail.com", first_name: "Dudu Mytsuka", last_name: "", nickname: "Dudu Mytsuka", birth_date: "", points: 1500 },
    { email: "cayo@gmail.com", first_name: "Cayo", last_name: "", nickname: "Cayo", birth_date: "", points: 1500 },
    { email: "tales@gmail.com", first_name: "Tales", last_name: "", nickname: "Tales", birth_date: "", points: 1500 },
    { email: "diogenes@gmail.com", first_name: "Diogenes", last_name: "", nickname: "Diogenes", birth_date: "", points: 1200 },
    { email: "eduardo@gmail.com", first_name: "Eduardo", last_name: "", nickname: "Eduardo", birth_date: "", points: 1200 },
    { email: "inacio@gmail.com", first_name: "Inacio", last_name: "", nickname: "Inacio", birth_date: "", points: 1200 },
    { email: "bruno@gmail.com", first_name: "Bruno", last_name: "", nickname: "Bruno", birth_date: "", points: 1200 },
    { email: "mateus@gmail.com", first_name: "Mateus", last_name: "", nickname: "Mateus", birth_date: "", points: 1200 },
    { email: "marcelo@gmail.com", first_name: "Marcelo", last_name: "", nickname: "Marcelo", birth_date: "", points: 1200 },
    { email: "lucas@gmail.com", first_name: "Lucas", last_name: "", nickname: "Lucas", birth_date: "", points: 1200 }
  ]

# Create users and update their points
users_info.each_with_index do |user_info, index|
  user = User.new(
    email: user_info[:email],
    password: "123456",
    first_name: user_info[:first_name],
    last_name: user_info[:last_name],
    nickname: user_info[:nickname],
    birth_date: user_info[:birth_date],
    points: user_info[:points]
  )
  avatar = URI.open("https://res.cloudinary.com/di7aefgt3/image/upload/v1686307789/development/f3qbrrthk6nt5moikyt7j3h4wg9c.png")
  user.photo.attach(io: avatar, filename:"Mon avatar")
  user.save!
end


match1 = Match.new({
  address: "68 Avenue Parmentier, 75011, Paris",
  match_type: "Desafio",
  modality: "Simples",
  price: "10",
  level: "500",
  date: DateTime.now
})
match1.user = user1
match1.save!

# match2 = Match.new({
#   address: "9 Avenue Marceau, 75008 Paris",
#   match_type: "Amical",
#   modality: "Simple",
#   price: "15",
#   level: "700",
#   date: (DateTime.now + 2)
# })
# match2.user = user2
# match2.save!

# match3 = Match.new({
#   address: "8 Rue du Bac, 75007 Paris",
#   match_type: "Amical",
#   modality: "Simple",
#   price: "6",
#   level: "200",
#   date: (DateTime.now + 1)
# })
# match3.user = user3
# match3.save!

# match4 = Match.new({
#   address: "3 Rue de Lappe, 75011 Paris",
#   match_type: "Défi",
#   modality: "Simple",
#   price: "10",
#   level: "400",
#   date: (DateTime.now + 1)
# })
# match4.user = user4
# match4.save!

# match5 = Match.new({
#   address: "2 Rue de Charonne, 75011 Paris",
#   match_type: "Amical",
#   modality: "Simple",
#   price: "20",
#   level: "400",
#   date: (DateTime.now + 1)
# })
# match5.user = user5
# match5.save!

# match6 = Match.new({
#   address: "7 Rue Sedaine, 75011 Paris",
#   match_type: "Amical",
#   modality: "Simple",
#   price: "5",
#   level: "600",
#   date: (DateTime.now + 2)
# })
# match6.user = user6
# match6.save!

# match7 = Match.new({
#   address: "10 Rue des Rosiers, 75004 Paris",
#   match_type: "Défi",
#   modality: "Simple",
#   price: "12",
#   level: "700",
#   date: (DateTime.now + 1)
# })
# match7.user = user7
# match7.save!

# match8 = Match.new({
#   address: "6 Rue Saint-Honoré, 75001 Paris",
#   match_type: "Défi",
#   modality: "Simple",
#   price: "10",
#   level: "500",
#   date: (DateTime.now + 1)
# })
# match8.user = user8
# match8.save!

# match9 = Match.new({
#   address: "4 Rue Oberkampf, 75011 Paris",
#   match_type: "Défi",
#   modality: "Simple",
#   price: "10",
#   level: "550",
#   date: (DateTime.now + 2)
# })
# match9.user = user9
# match9.save!

request1 = Request.new(status: 0, match_id: match1.id, user_id: User.last.id)
request1.save!

# request2 = Request.new(status: 0, match_id: match2.id, user_id: user1.id)
# request2.save!

# league1 = League.new(name: "Monde", user_id: user2.id)
# league1.image = "icon2.png"
# league1.save!


league1 = League.new(name: "Paris", user_id: user1.id)
league1.image = "icon3.png"
league1.save!


membership1 = Membership.new(user_id: user1.id, league_id: league1.id)
membership1.save!


# membership2 = Membership.new(user_id: user2.id, league_id: league2.id)
# membership2.save!

# membership3 = Membership.new(user_id: user1.id, league_id: league2.id)
# membership3.save!
