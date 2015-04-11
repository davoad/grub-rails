require 'rails_helper'

RSpec.describe Recipe, :type => :model do
  it { should validate_presence_of(:name) }
  it { should validate_numericality_of(:page_number) }
  it { should validate_numericality_of(:preparation_time) }
  it { should validate_numericality_of(:cooking_time) }

  it { should have_many(:users).through(:ratings) }

  it { should belong_to(:publication) }
  it { should accept_nested_attributes_for :publication }

  it 'is invalid without a name' do
    recipe = build(:recipe, name: nil)
    expect(recipe).to have(1).errors_on(:name)
  end

  it 'is valid with a nil preparation time' do
    recipe = build(:recipe, preparation_time: nil)
    expect(recipe).to have(0).errors_on(:preparation_time)
  end

  it 'is valid with a nil cooking time' do
    recipe = build(:recipe, cooking_time: nil)
    expect(recipe).to have(0).errors_on(:cooking_time)
  end
end
