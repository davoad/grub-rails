class Recipe < ActiveRecord::Base
  validates_presence_of :name
  validates_numericality_of :page_number, only_integer: true
  validates_numericality_of :preparation_time, only_integer: true, allow_nil: true
  validates_numericality_of :cooking_time, only_integer: true, allow_nil: true
  belongs_to :publication
  has_many :ratings
  has_many :users, through: :ratings

  accepts_nested_attributes_for :publication, reject_if: :all_blank
  accepts_nested_attributes_for :publication, reject_if: :all_blank
  accepts_nested_attributes_for :ratings, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :users

  def tag_list
    tags.join(',')
  end

  def tag_list=(list)
    self.tags = list.split(',').map(&:strip)
  end

  def rating_for_user(user_id)
    rating = ratings.find_by(user_id: user_id, recipe_id: id)
    rating || ratings.build(user_id:  user_id, recipe_id: id)
  end
end
