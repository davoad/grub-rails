class Recipe < ActiveRecord::Base
  include PgSearch
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

  pg_search_scope :search, against: [:name, :tags],
                  using: {tsearch: {dictionary: 'english'}},
                  associated_against: { publication: [:name, :author], users: [:first_name, :last_name], ratings: [:value] }

  def self.text_search(search)
    puts search
    if search.present?
      search(search)
    else
      order('LOWER(name)')
    end
  end

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
