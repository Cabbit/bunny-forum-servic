class CreateForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
      t.string :description, null: false
      t.integer :topics_count, null: false, default: 0
      t.integer :posts_count, null: false, default: 0
      t.integer :last_poster_id, null: true
      t.date :last_posted_at, null: true
      t.timestamps null: false
    end
  end
end
