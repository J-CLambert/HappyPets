# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "faker"
require 'cloudinary'


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
5.times do
  mail = Faker::Internet.email
  user = User.create!(
      name: mail,
      email: mail,
      password: mail,
      address: address.shuffle.first,
      breeder: boolean.shuffle.first
      )

      puts 'Creating 5 fake pets per user...'

      5.times do
        pet = Pet.create!(
          name: Faker::Name.name,
          price: Faker::Commerce.price(range: 10..50),
          breed: Faker::Creature::Horse.breed,
          description: Faker::Quote.yoda,
          title: Faker::Quote.famous_last_words,
          birthday: Faker::Date.between(from: '1940-09-23', to: Date.today),
          vaccinated_against: Faker::JapaneseMedia::StudioGhibli.character,
          user_id: User.pluck(:id).sample,
          species: species.shuffle.first,
          photos: Cloudinary::Utils.cloudinary_url("v6f2jtssebai8xl6xuiiqyg4gdr0", secure: true) # Remplacez "sample" par le nom de votre image par défaut dans Cloudinary
        )
      end


      puts 'Finish creating fake pets per user.'

end

puts  "creating requests"
  20.times do
    request = Request.create!(
      message: Faker::Quotes::Shakespeare.king_richard_iii_quote,
      title: Faker::Quotes::Shakespeare.as_you_like_it_quote,
      visit_date: Date.today,
      pet_id: Pet.pluck(:id).sample,
      user_id: User.pluck(:id).sample
    )
  end
