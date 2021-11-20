class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :genre_id
      t.string :item_name
      t.string :image_id
      t.text :detail
      t.integer :price
      t.integer :item_status

      t.timestamps
    end
  end
end
