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

vaccinated_list = ['Salmonellosis', 'Rabies', 'Mites', 'Ticks', 'Fungal Infections']
pets_info = [
#cats
  {
    name: "Nala",
    description: "This cat has a personality as vibrant as a sunbeam. Social and playful, it loves being the star of the show and will seize every opportunity to capture attention, whether by playing with its favourite toys or hopping on your lap when you're trying to work. This cat's antics never fail to bring a smile.",
    photo1_path:"app/assets/images/all_cats/cat1/photo-1570419868699-b5e996ef2796.avif",
    photo2_path: "app/assets/images/all_cats/cat1/photo-1582530182198-98b5312880f6.avif",
    breed: "European Shorthair",
    species: "cat"
  },
  photo1_path:
  photo2_path:
  breed:
  {
    name: "Buddy",
    description: "Buddy is the embodiment of serenity. Preferring to spend his days observing the world from the window or sleeping peacefully in a cozy corner, he personifies calmness. He also adores his petting sessions and will live by the motto, 'live and let live'.",
    photo1_path:
    photo2_path:
    breed:
    species: "cat"
  },

  {
    name: "Whiskers",
    description: "Whiskers is a feline with a big heart. He is extremely sociable and will spend countless hours purring in your lap, always ready for a cuddle. But when he's not dozing off, he enjoys a good game of hide-and-seek or chasing after a piece of string. His combination of curiosity and affection makes him the perfect companion.",
    photo1_path:
    photo2_path:
    breed:
    species: "cat"
  },
  
  {
    name: "Shadow",
    description: "Shadow is the kind of cat that exudes independence. He loves exploring every nook and cranny of the house and is often the first to discover new spaces. With his adventurous spirit, Shadow ensures that every day is filled with surprises and new discoveries.",
    photo1_path:
    photo2_path:
    breed:
    species: "cat"
  },
#dogs
  {
    name: "Rex",
    description: "Rex is a playful companion who loves nothing more than a good game of fetch. His energetic nature is infectious and will have you joining in the fun in no time. His loyalty and affection make him a perfect family pet.",
    photo1_path:
    photo2_path:
    breed:
    species: "dog"
  },

  {
    name: "Lucky",
    description: "Lucky is a gentle soul who enjoys quiet moments. He likes to spend time relaxing by your side and is content with just your presence. His calm demeanor makes him a great companion for those peaceful evenings at home.",
    photo1_path:
    photo2_path:
    breed:
    species: "dog"
  },

  {
    name: "Bella",
    description: "Bella is a charming dog with a keen sense of curiosity. She loves to explore her surroundings and sniff out new adventures. Her lively spirit ensures there's never a dull moment when she's around.",
    photo1_path:
    photo2_path:
    breed:
    species: "dog"
  },

  {
    name: "Max",
    description: "Max is a loyal and protective companion. He has a keen sense of his surroundings and is always alert. His protective nature makes him a great guard dog, and his loyalty makes him a cherished member of any family.",
    photo1_path:
    photo2_path:
    breed:
    species: "dog"
  },
#birds
  {
    name: "Chirpy",
    description: "Chirpy is an absolute delight to have around. His melodious tunes bring joy to every morning, and his playful nature brings a smile to everyone's face. His cheerful demeanor is sure to brighten up any home.",
    photo1_path:
    photo2_path:
    breed:
    species: "bird"
  },

  {
    name: "Feathers",
    description: "Feathers is a serene and peaceful companion. She enjoys gazing out the window and watching the world go by. Her quiet presence brings a sense of calm and tranquility to any environment.",
    photo1_path:
    photo2_path:
    breed:
    species: "bird"
  },

  {
    name: "Sky",
    description: "Sky is a lively bird with an adventurous spirit. She loves to explore her surroundings and is always looking for new things to learn. Her curiosity and zest for life make her a fascinating companion.",
    photo1_path:
    photo2_path:
    breed:
    species: "bird"
  },

  {
    name: "Squawk",
    description: "Squawk is an expressive bird with a lot to say. He's not shy about communicating his needs and is always ready for some interaction. His vibrant personality will keep you entertained and engaged.",
    photo1_path:
    photo2_path:
    breed:
    species: "bird"
  },
#snake
    {
    name: "Slinky",
    description: "Slinky is a curious and observant creature, always eager to explore its surroundings. While it prefers to spend time alone, Slinky is remarkably attuned to its environment and is fascinating to watch as it navigates its world.",
    photo1_path:
    photo2_path:
    breed:
    species: "snake"
  },

  {
    name: "Serpentor",
    description: "Serpentor is a calm and peaceful snake. It's a delight for anyone who appreciates tranquility. It prefers a calm, quiet environment and makes for a fascinating, low-maintenance companion.",
    photo1_path:
    photo2_path:
    breed:
    species: "snake"
  },

  {
    name: "Hiss",
    description: "Hiss has a vibrant and engaging personality. It is active and enjoys having a variety of activities in its habitat. Watching Hiss explore is an adventure in itself, making it a captivating companion.",
    photo1_path:
    photo2_path:
    breed:
    species: "snake"
  },

  {
    name: "Viper",
    description: "Viper is a majestic and regal creature, carrying a unique sense of quiet dignity. It is low-maintenance and is content to observe the world around it with a calm and poised demeanor, making it an intriguing companion.",
    photo1_path:
    photo2_path:
    breed:
    species: "snake"
  }
]
pets_info.each_with_index do |pet_info, pet_number|
  pet = Pet.new(
    title: pets_info[pet_number][:name],
    name: pets_info[pet_number][:name],
    price: Faker::Commerce.price(range: 10..500),
    breed: pets_info[pet_number][:breed],
    description: pets_info[pet_number][:description],
    birthday: Faker::Date.between(from: '2020-09-23', to: Date.today),
    vaccinated_against: vaccinated_list.shuffle.first(rand(1..vaccinated_list.length)).join(', '),
    user_id: User.pluck(:id).sample,
    species: pets_info[pet_number][:species],
  )
  pet.photos.attach([{
      io: Rails.root.join(pets_info[pet_number][:photo1_path]).open,
      filename: "photo_pet#{pet_number}.png",
      content_type: 'image/png'
    },
    {
      io: Rails.root.join(pets_info[pet_number][:photo2_path]).open,
      filename: "photo_pet#{pet_number}.png",
      content_type: 'image/png'
    }
  ])

  pet.save!
end









  puts 'Finish creating fake pets per user.'
