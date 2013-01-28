FactoryGirl.define do
	factory :breve do |f|
		f.title Faker::Company.catch_phrase
		f.location Faker::Address.street_address
		f.description Faker::Lorem.paragraph(3)
		f.source_name Faker::Company.name
		f.source_URL "http://" + Faker::Internet.domain_name
		f.latitude Random::rand(-89.99..89.99)
		f.longitude Random::rand(-179.99..179.99)
	end
end