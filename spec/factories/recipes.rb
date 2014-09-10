FactoryGirl.define do
  factory :recipe do
    name "The worlds greatest pie"

    factory :invalid_recipe do
      name nil
    end

    factory :recipe_with_publication do
      association :publication, factory: :publication, strategy: :create
    end

  end
end
