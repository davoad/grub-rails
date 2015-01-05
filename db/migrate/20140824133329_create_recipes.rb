class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name, null: false
      t.integer :page_number, null: true
      t.belongs_to :publication
      t.belongs_to :website
      t.text :tags, array: true, default: []
      t.timestamps
    end
  end
end
