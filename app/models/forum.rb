# frozen_string_literal: true
class Forum < ActiveRecord::Base
  belongs_to :forum
  has_many :forums

  validates :description, presence: true

  def increment_posts_counter!
    increment!(:posts_count, 1)
  end

  def increment_topics_counter!
    increment!(:topics_count, 1)
  end
end
