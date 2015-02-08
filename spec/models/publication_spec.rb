require 'rails_helper'

RSpec.describe Publication, :type => :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:author) }
  it { should have_many(:recipe) }

  it 'is invalid without a name' do
    recipe = build(:publication, name: nil)
    expect(recipe).to have(1).errors_on(:name)
  end

  it 'is invalid without an author' do
    recipe = build(:publication, author: nil)
    expect(recipe).to have(1).errors_on(:author)
  end

  it 'is invalid without an edition' do
    recipe = build(:publication, edition: nil)
    expect(recipe).to have(1).errors_on(:edition)
  end
end
