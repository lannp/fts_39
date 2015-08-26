FactoryGirl.define do
  factory :exam do
    category FactoryGirl.create :category
  end
end
