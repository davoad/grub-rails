require 'rails_helper'

RSpec.describe Rating, :type => :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:value) }
  it { should validate_numericality_of(:value).is_greater_than_or_equal_to(0).is_less_than_or_equal_to(5) }

  it { should belong_to(:user) }
  it { should belong_to(:recipe) }
end
