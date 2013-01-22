# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do |u|
    u.name Faker::Name.first_name + Faker::Name.last_name
    u.email Faker::Internet.email
    u.password "foobar"
    u.password_confirmation "foobar"
  end
end
