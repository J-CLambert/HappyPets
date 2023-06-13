# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "faker"
require 'cloudinary'
require "open-uri"


puts 'Deleting requests'
Request.delete_all
puts 'Deleting pets'
Pet.delete_all
puts 'Deleting previous users'
User.delete_all

species = ["dog","cat","bird","snake"]
boolean = ["true", "false"]
address = ["Via Albarelle 58, Ascona, switzerland",
          "Rue de Saint-Jean 90, Geneva, Switzerland",
          "Spinatsch 41, Trin, Switzerland",
          "Rue Sismondi 3, Geneva, Switzerland",
          "Chemin des Petits-Bois 30, Geneva, Switzerland",
          "54 Plattenstrasse, zurich, switzerland",
          "20 Chemin de la Bâtie, Geneva, switzerland",
          "27 Spitalstrasse, Aargau, Switzerland",
          "Chemin la Planie 38, Wallis, Switzerland"
        ]
        1.times do
          mail = Faker::Internet.email
          user = User.create!(
            name: mail,
            email: mail,
            password: mail,
            address: address.shuffle.first,
            breeder: boolean.shuffle.first
          )
        end

puts 'Creating 1 fake pets per user...'


  photos_cat_1 = []
  photos_cat_1 << {
    io: URI.open("https://wannacat.org/wp-content/uploads/2020/12/DSC03387-2.jpg"),
    filename: 'photo_cat_1_1.png',
    content_type: 'image/png'
  }
  photos_cat_1 << {
    io: URI.open("https://images.prismic.io/trustedhousesitters/ee6e6fb5-a9a3-402a-9af5-314fabe7c69a_siamese+cat.png?auto=compress,format&rect=0,0,1920,800&w=960&h=400"),
    filename: 'photo_cat_1_2.png',
    content_type: 'image/png'
  }
  file_cat = URI.open("https://www.rd.com/wp-content/uploads/2021/04/GettyImages-145679137-scaled-e1619025176434.jpg?w=2515")
    pet = Pet.new(
      name: Faker::Name.name,
      price: Faker::Commerce.price(range: 10..50),
      breed: Faker::Creature::Horse.breed,
      description: Faker::Quote.yoda,
      title: Faker::Quote.famous_last_words,
      birthday: Faker::Date.between(from: '1940-09-23', to: Date.today),
      vaccinated_against: Faker::JapaneseMedia::StudioGhibli.character,
      user_id: User.pluck(:id).sample,
      species: species.shuffle.first,
    )
  pet.photos.attach(photos_cat_1)
  pet.save

  puts 'Finish creating fake pets per user.'
