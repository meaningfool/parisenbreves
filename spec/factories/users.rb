# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:name) {|u| "Person_#{u}"}
    sequence(:email) {|u| "person_#{u}@example.com"}
    password "foobar"
    password_confirmation "foobar"
   	role "guest"

    factory :standard do
    	role "standard"
    end

    factory :editor do
    	role "editor"
    end

    factory :admin do
    	role "admin"
    end
  end
end
