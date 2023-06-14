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
3.times do
  mail = Faker::Internet.email
  user = User.create!(
    name: mail,
    email: mail,
    password: mail,
    address: address.shuffle.first,
    breeder: boolean.shuffle.first
  )
end

mail = Faker::Internet.email
user = User.create!(
  name: "Terri",
  email: mail,
  password: mail,
  address: address.shuffle.first,
  breeder: true
)

mail = Faker::Internet.email
user = User.create!(
  name: "Jean-Christophe",
  email: mail,
  password: mail,
  address: address.shuffle.first,
  breeder: false
)

puts 'Creating 5 fake pets per user...'

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

  {
    name: "Buddy",
    description: "Buddy is the embodiment of serenity. Preferring to spend his days observing the world from the window or sleeping peacefully in a cozy corner, he personifies calmness. He also adores his petting sessions and will live by the motto, 'live and let live'.",
    photo1_path:"app/assets/images/all_cats/cat2/photo-1549878569-a8105b1188b8.avif",
    photo2_path:"app/assets/images/all_cats/cat2/photo-1572590603603-f828f6682212.avif",
    breed: "Simaese",
    species: "cat"
  },

  {
    name: "Whiskers",
    description: "Whiskers is a feline with a big heart. He is extremely sociable and will spend countless hours purring in your lap, always ready for a cuddle. But when he's not dozing off, he enjoys a good game of hide-and-seek or chasing after a piece of string. His combination of curiosity and affection makes him the perfect companion.",
    photo1_path: "app/assets/images/all_cats/cat3/photo-1517035753523-2077b746904d.avif",
    photo2_path: "app/assets/images/all_cats/cat3/photo-1517035753523-2077b746904d.avif",
    breed: "strange cat",
    species: "cat"
  },
  
  {
    name: "Shadow",
    description: "Shadow is the kind of cat that exudes independence. He loves exploring every nook and cranny of the house and is often the first to discover new spaces. With his adventurous spirit, Shadow ensures that every day is filled with surprises and new discoveries.",
    photo1_path: "app/assets/images/all_cats/cat4/photo-1603349136285-53f2273130f5.avif",
    photo2_path: "app/assets/images/all_cats/cat4/photo-1603349136483-c9087327668c.avif",
    breed: "Ragamuffin",
    species: "cat"
  },
#dogs
  {
    name: "Rex",
    description: "Rex is a playful companion who loves nothing more than a good game of fetch. His energetic nature is infectious and will have you joining in the fun in no time. His loyalty and affection make him a perfect family pet.",
    photo1_path: "app/assets/images/all_dogs/dog1/photo-1546527868-ccb7ee7dfa6a.avif",
    photo2_path: "app/assets/images/all_dogs/dog1/photo-1526441153054-3649ed0e0187.avif",
    breed: "Yorkshire",
    species: "dog"
  },

  {
    name: "Lucky",
    description: "Lucky is a gentle soul who enjoys quiet moments. He likes to spend time relaxing by your side and is content with just your presence. His calm demeanor makes him a great companion for those peaceful evenings at home.",
    photo1_path: "app/assets/images/all_dogs/dog2/photo-1615233500022-01d251f3eb33.avif",
    photo2_path: "app/assets/images/all_dogs/dog2/photo-1615233500064-caa995e2f9dd.avif",
    breed: "Labrador Retriever",
    species: "dog"
  },

  {
    name: "Bella",
    description: "Bella is a charming dog with a keen sense of curiosity. She loves to explore her surroundings and sniff out new adventures. Her lively spirit ensures there's never a dull moment when she's around.",
    photo1_path: "app/assets/images/all_dogs/dog3/photo-1544568100-847a948585b9.avif",
    photo2_path: "app/assets/images/all_dogs/dog3/photo-1544568100-847a948585b9.avif",
    breed: "Golden retriever",
    species: "dog"
  },

  {
    name: "Max",
    description: "Max is a loyal and protective companion. He has a keen sense of his surroundings and is always alert. His protective nature makes him a great guard dog, and his loyalty makes him a cherished member of any family.",
    photo1_path: "app/assets/images/all_dogs/dog4/photo-1594149929911-78975a43d4f5.avif",
    photo2_path: "app/assets/images/all_dogs/dog4/photo-1627366247844-b4b5df8854d8.avif",
    breed: "Golden retriever",
    species: "dog"
  },
#birds
  {
    name: "Chirpy",
    description: "Chirpy is an absolute delight to have around. His melodious tunes bring joy to every morning, and his playful nature brings a smile to everyone's face. His cheerful demeanor is sure to brighten up any home.",
    photo1_path: "app/assets/images/all_birds/bird1/photo-1452570053594-1b985d6ea890.avif",
    photo2_path: "app/assets/images/all_birds/bird1/photo-1512819432727-dbcb57a06f13.avif",
    breed: "Blue-yellow macaw",
    species: "bird"
  },

  {
    name: "Feathers",
    description: "Feathers is a serene and peaceful companion. She enjoys gazing out the window and watching the world go by. Her quiet presence brings a sense of calm and tranquility to any environment.",
    photo1_path: "app/assets/images/all_birds/bird2/photo-1574626003470-ac963a52dc7e.avif",
    photo2_path: "app/assets/images/all_birds/bird2/photo-1606567595334-d39972c85dbe.avif",
    breed: "Redthroat",
    species: "bird"
  },

  {
    name: "Sky",
    description: "Sky is a lively bird with an adventurous spirit. She loves to explore her surroundings and is always looking for new things to learn. Her curiosity and zest for life make her a fascinating companion.",
    photo1_path: "app/assets/images/all_birds/bird3/photo-1507126882445-434b04530d1a.avif",
    photo2_path: "app/assets/images/all_birds/bird3/photo-1580980407668-6bb45a674180.avif",
    breed: "Dove",
    species: "bird"
  },

  {
    name: "Squawk",
    description: "Squawk is an expressive bird with a lot to say. He's not shy about communicating his needs and is always ready for some interaction. His vibrant personality will keep you entertained and engaged.",
    photo1_path: "app/assets/images/all_birds/bird4/photo-1482330625994-3bb3c90a5d05.avif",
    photo2_path: "app/assets/images/all_birds/bird4/photo-1591201784043-7b46c512ff92.avif",
    breed: "Northern cardinal",
    species: "bird"
  },
#snake
    {
    name: "Slinky",
    description: "Slinky is a curious and observant creature, always eager to explore its surroundings. While it prefers to spend time alone, Slinky is remarkably attuned to its environment and is fascinating to watch as it navigates its world.",
    photo1_path: "app/assets/images/all_snake/snake1/photo-1613176874714-d99dbcf40973.avif",
    photo2_path: "app/assets/images/all_snake/snake1/photo-1613176875265-8d8da7d7674f.avif",
    breed: "Boa constrictor",
    species: "snake"
  },

  {
    name: "Serpentor",
    description: "Serpentor is a calm and peaceful snake. It's a delight for anyone who appreciates tranquility. It prefers a calm, quiet environment and makes for a fascinating, low-maintenance companion.",
    photo1_path: "app/assets/images/all_snake/snake2/photo-1555455955-c2e1feb6f81c.avif",
    photo2_path: "app/assets/images/all_snake/snake2/photo-1672397910784-a52fbb71ecf9.avif",
    breed: "Royal python",
    species: "snake"
  },

  {
    name: "Hiss",
    description: "Hiss has a vibrant and engaging personality. It is active and enjoys having a variety of activities in its habitat. Watching Hiss explore is an adventure in itself, making it a captivating companion.",
    photo1_path: "app/assets/images/all_snake/snake3/photo-1538439907460-1596cafd4eff.avif",
    photo2_path: "app/assets/images/all_snake/snake3/photo-1600333527715-cc7f665bc332.avif",
    breed: "Boa constrictor",
    species: "snake"
  },

  {
    name: "Viper",
    description: "Viper is a majestic and regal creature, carrying a unique sense of quiet dignity. It is low-maintenance and is content to observe the world around it with a calm and poised demeanor, making it an intriguing companion.",
    photo1_path: "app/assets/images/all_snake/snake4/photo-1553676754-b7b91652ad55.avif",
    photo2_path: "app/assets/images/all_snake/snake4/photo-1675248043962-6415f05c803e.avif",
    breed: "Boa constrictor",
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
