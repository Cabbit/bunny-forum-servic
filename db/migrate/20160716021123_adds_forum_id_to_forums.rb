class AddsForumIdToForums < ActiveRecord::Migration
  def change
    add_column :forums, :forum_id, :integer, null: true
  end
end
