# frozen_string_literal: true
class Topic < ActiveRecord::Base
  belongs_to :forum
  has_many :posts
  after_create { increment_forum_topics_counter! }

  validates :title, presence: true

  def increment_views_counter!
    increment!(:views_count, 1)
  end

  def increment_replies_counter!
    increment!(:replies_count, 1)
    forum.increment_posts_counter!
  end

  private

  def increment_forum_topics_counter!
    forum.increment_topics_counter!
  end
end
