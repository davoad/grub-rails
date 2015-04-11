class Rating < ActiveRecord::Base
  validates_presence_of :title
  validates_presence_of :value
  validates_numericality_of :value, greater_than_or_equal_to: 0, less_than_or_equal_to: 5
  belongs_to :user
  belongs_to :recipe
  accepts_nested_attributes_for :user, reject_if: :all_blank
end
