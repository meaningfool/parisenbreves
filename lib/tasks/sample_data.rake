namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    standard = User.new(name: "standard",
                 email: "standard@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar")
    standard.role = "standard"
    standard.save!

    editor = User.new(name: "editor",
                 email: "editor@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar")
    editor.role = "editor"
    editor.save!

    admin = User.new(name: "admin",
                 email: "admin@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar")
    admin.role = "admin"
    admin.save!
    
    49.times do |n|
      name  = "User_#{n+1}"
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      fake_user = User.new(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
      fake_user.role = "guest"
      fake_user.save!
    end

    100.times do |b|
      title = Faker::Company.catch_phrase
      location = Faker::Address.street_address
      description = Faker::Lorem.paragraph(3)
      source_name = Faker::Company.name
      source_URL = "http://" + Faker::Internet.domain_name
      latitude = Random::rand(48.8..48.93)
      longitude = Random::rand(2.2..2.5)
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