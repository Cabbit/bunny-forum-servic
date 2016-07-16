class AddsTopicIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :topic_id, :integer, null: false
  end
end
