# frozen_string_literal: true
class TopicSerializer
  include JSONAPI::Serializer

  attribute :forum_id
  attribute :title
  attribute :replies_count
  attribute :views_count
  attribute :last_poster_id
  attribute :last_posted_at
end
