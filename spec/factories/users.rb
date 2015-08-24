FactoryGirl.define do
  factory :user do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    admin false
    password "12341234"
    
    factory :admin do
      admin true
    end
  end
end
