FactoryGirl.define do
  factory :question do
    content {Faker::Name.name}
  end
end
