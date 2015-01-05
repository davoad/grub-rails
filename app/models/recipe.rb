class Recipe < ActiveRecord::Base
  validates_presence_of :name
  validates_numericality_of :page_number, only_integer: true
  belongs_to :publication
  belongs_to :website
  accepts_nested_attributes_for :publication, reject_if: :all_blank

  def tag_list
    tags.join(',')
  end

  def tag_list=(list)
    self.tags = list.split(',').map(&:strip)
  end
end
