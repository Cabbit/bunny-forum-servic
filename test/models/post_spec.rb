# frozen_string_literal: true
require_relative '../test_helper'

class PostsTest < TestCase
  let(:post) { posts(:a) }

  it 'should update the post title' do
    post.title = 'Post B'
    assert post.save
  end
end
