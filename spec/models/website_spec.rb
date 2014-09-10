require 'rails_helper'

RSpec.describe Website, :type => :model do
  it { should have_many(:recipe) }
end
