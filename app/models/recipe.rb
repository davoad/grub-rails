class Recipe < ActiveRecord::Base
  validates_presence_of :name
  belongs_to :publication
  belongs_to :website
  accepts_nested_attributes_for :publication
end
