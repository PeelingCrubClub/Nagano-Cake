class ChangeDatatype < ActiveRecord::Migration[5.2]
  def change
     change_column :items, :item_status, :boolean, default: false, null: false
  end
end
