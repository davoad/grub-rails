class Publication < ActiveRecord::Base
  has_many :recipe
  validates_presence_of :name
  validates_presence_of :author
  validates_presence_of :edition
end
