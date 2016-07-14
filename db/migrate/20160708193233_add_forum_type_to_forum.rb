class AddForumTypeToForum < ActiveRecord::Migration
  def change
    add_column :forums, :forum_type, :string, null: false
  end
end
