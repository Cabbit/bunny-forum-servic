# frozen_string_literal: true
class Post < ActiveRecord::Base
  belongs_to :topic
  has_one :forum, through: :topic

  after_create do
    increment_topic_replies_count!
    increment_forum_post_count!
  end

  validates :title, presence: true

  def increment_topic_replies_count!
    topic.increment!(:replies_count, 1)
  end

  def increment_forum_post_count!
    forum.increment!(:posts_count, 1)
  end
end
