# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rating do
    association :recipe, factory: :recipe
    value 4
    title 'My great title'
    comments 'Very insightful comments'

    factory :invalid_rating do
      value nil
    end

    factory :rating_with_recipe_and_user do
      association :recipe, factory: :recipe, strategy: :create
      association :user, factory: :user, strategy: :create
    end

    factory :rating_with_recipe do
      association :recipe, factory: :recipe, strategy: :create
    end
  end
end
