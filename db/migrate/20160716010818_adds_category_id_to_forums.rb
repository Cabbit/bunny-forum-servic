class AddsCategoryIdToForums < ActiveRecord::Migration
  def change
    add_column :forums, :category_id, :integer, null: true
  end
end
