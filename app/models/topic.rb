# frozen_string_literal: true
class Topic < ActiveRecord::Base
  belongs_to :forum
  has_many :posts

  validates :title, presence: true

  def increment_views_counter!
    increment!(:views_count, 1)
  end

  def increment_replies_counter!
    increment!(:replies_count, 1)
    forum.increment!(:posts_count, 1)
  end
end
