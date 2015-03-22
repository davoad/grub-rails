FactoryGirl.define do
  factory :recipe do
    name 'The worlds greatest pie'
    page_number 145
    tag_list 'aa, bb' 
    preparation_time 20
    cooking_time 110

    factory :invalid_recipe do
      name nil
    end

    factory :recipe_with_publication do
      association :publication, factory: :publication, strategy: :create
    end

  end
end
