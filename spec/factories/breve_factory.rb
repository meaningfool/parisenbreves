FactoryGirl.define do
	factory :breve do |f|
		f.title "title"
		f.location "location"
		f.description "description"
		f.source_name "Wikipedia"
		f.source_URL "http://wikipedia.com"
		f.latitude "0.2"
		f.longitude "0.4"
	end
end