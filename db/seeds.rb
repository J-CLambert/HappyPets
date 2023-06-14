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
    io: File.open("../../app/assets/images/all_cats/cat1/photo-1570419868699-b5e996ef2796.avif"),
    filename: 'photo_cat1_1.png',
    content_type: 'image/png'
  }
  photos_cat_1 << {
    io: File.open("../../app/assets/images/all_cats/cat1/photo-1582530182198-98b5312880f6.avif"),
    filename: 'photo_cat1_2.png',
    content_type: 'image/png'
  }
    pet = Pet.new(
      name: "Nala",
      price: Faker::Commerce.price(range: 10..500),
      breed: "European Shorthair",
      description: "This cat has a personality as vibrant as a sunbeam. Social and playful, it loves being the star of the show and will seize every opportunity to capture attention, whether by playing with its favourite toys or hopping on your lap when you're trying to work. This cat's antics never fail to bring a smile.",
      title: "Nala",
      birthday: Faker::Date.between(from: '2020-09-23', to: Date.today),
      vaccinated_against: "Typhus, Coryza, FeLV",
      user_id: User.pluck(:id).sample,
      species: "cat",
    )
  pet.photos.attach(photos_cat_1)
  pet.save



  photos_cat2 = []
  photos_cat2 << {
    io: File.open("../../app/assets/images/all_cats/cat2/photo-1549878569-a8105b1188b8.avif"),
    filename: 'photo_cat2_1.png',
    content_type: 'image/png'
  }
  photos_cat2 << {
    io: File.open("../../app/assets/images/all_cats/cat2/photo-1572590603603-f828f6682212.avif"),
    filename: 'photo_cat2_2.png',
    content_type: 'image/png'
  }
    pet = Pet.new(
      name: "Félix",
      price: Faker::Commerce.price(range: 10..500),
      breed: "siamese",
      description: "Gentle and loving, this feline is the embodiment of affection. It will spend countless hours purring in your lap, always ready for a cuddle. But when it's not dozing off, it enjoys a good game of hide-and-seek or chasing after a piece of string. This cat's combination of curiosity and affection makes it the perfect companion.",
      title: "Félix",
      birthday: Faker::Date.between(from: '2020-09-23', to: Date.today),
      vaccinated_against: "Coryza,Typhus",
      user_id: User.pluck(:id).sample,
      species: "cat",
    )
  pet.photos.attach(photos_cat2)
  pet.save

  puts 'Finish creating fake pets per user.'
