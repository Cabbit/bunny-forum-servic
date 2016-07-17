# frozen_string_literal: true
class Post < ActiveRecord::Base
  belongs_to :topic
  after_create { increment_topic_replies_count! }

  validates :title, presence: true

  def increment_topic_replies_count!
    topic.increment!(:replies_count, 1)
  end
end
