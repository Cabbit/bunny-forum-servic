# frozen_string_literal: true
class Post < ActiveRecord::Base
  belongs_to :topic
  has_one :forum, through: :topic

  after_create do
    increment_topic_replies_count!
  end

  validates :title, presence: true

  def increment_topic_replies_count!
    topic.increment_replies_counter!
  end
end
