FactoryGirl.define do
  factory :recipe do
    name 'The worlds greatest pie'
    page_number 145
    tag_list 'aa, bb' 

    factory :invalid_recipe do
      name nil
    end

    factory :recipe_with_publication do
      association :publication, factory: :publication, strategy: :create
    end

  end
end
