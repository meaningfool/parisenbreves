namespace :db do
  desc "Fill database with sample subjects"
  task subjects: :environment do
  	50.times do |b|
      title = Faker::Company.catch_phrase
      description = Faker::Lorem.paragraph(3)
      Subject.create!(title: title,
                    description: description,
                    status: 'active')
     end 

     50.times do |b|
      title = Faker::Company.catch_phrase
      description = Faker::Lorem.paragraph(3)
      Subject.create!(title: title,
                    description: description,
                    status: 'treated')
     end 
  end
end