class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.string :name, null: false
      t.string :author, null: true
      t.string :edition, null: true
      t.timestamps
    end
  end
end
