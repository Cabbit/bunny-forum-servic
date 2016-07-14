# frozen_string_literal: true
class ForumSerializer
  include JSONAPI::Serializer

  attribute :forum_id
  attribute :title
  attribute :description
  attribute :topics_count
  attribute :posts_count
  attribute :last_poster_id
  attribute :last_posted_at
end
