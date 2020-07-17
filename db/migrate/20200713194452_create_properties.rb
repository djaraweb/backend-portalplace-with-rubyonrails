class CreateProperties < ActiveRecord::Migration[6.0]
  def change
    create_table :properties do |t|
      t.string :placehouse
      t.string :title
      t.integer :mts2
      t.string :street
      t.decimal :geolat
      t.decimal :geolng
      t.integer :visits
      t.float :price
      t.string :urlimage
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
