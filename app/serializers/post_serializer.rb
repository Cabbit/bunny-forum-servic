# frozen_string_literal: true
class PostSerializer
  include JSONAPI::Serializer

  attribute :title
end
