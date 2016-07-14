class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer :forum_id, null: false
      t.string :title, null: false
      t.integer :views_count, null: false, default: 0
      t.integer :replies_count, null: false, default: 0
      t.integer :last_poster_id, null: true
      t.date :last_posted_at, null: true
      t.timestamps null: false
    end
  end
end
