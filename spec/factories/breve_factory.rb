FactoryGirl.define do
	factory :breve do |f|
		f.title Faker::Company.catch_phrase
		f.location Faker::Address.street_address
		f.description Faker::Lorem.paragraph(3)
		f.source_name Faker::Company.name
		f.source_URL "http://" + Faker::Internet.domain_name
		f.latitude Random::rand(-Math::PI/4..Math::PI/4)
		f.longitude Random::rand(-Math::PI/2..Math::PI/2)
	end
end