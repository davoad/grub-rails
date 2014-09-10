FactoryGirl.define do
  factory :publication do
    name 'A Great Publication'
    author 'Bob Jones'

    factory :invalid_publication do
      name nil
    end
  end
end
