FactoryGirl.define do
  factory :category do
    name {Faker::Name.name}
  end

  factory :invalid_category1 do
    name ""
  end
end
