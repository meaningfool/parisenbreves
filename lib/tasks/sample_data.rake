namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    admin = User.create!(name: "ExampleUser",
                 email: "example@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar")
    admin.toggle!(:admin)
    
    49.times do |n|
      name  = "User_#{n+1}"
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    100.times do |b|
      title = Faker::Company.catch_phrase
      location = Faker::Address.street_address
      description = Faker::Lorem.paragraph(3)
      source_name = Faker::Company.name
      source_URL = "http://" + Faker::Internet.domain_name
      latitude = Random::rand(-Math::PI/4..Math::PI/4)
      longitude = Random::rand(-Math::PI/2..Math::PI/2)
      Breve.create!(title: title,
                    location: location,
                    description: description,
                    source_name: source_name,
                    source_URL: source_URL,
                    latitude: latitude,
                    longitude: longitude)
     end 
  end
end