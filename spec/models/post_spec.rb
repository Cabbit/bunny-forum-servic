# frozen_string_literal: true
require_relative '../spec_helper'

class PostsTest < TestCase
  let(:post) { posts(:a) }

  describe '#title' do
    context 'when empty' do
      it 'should raise a validation error' do
        post.title = ''
        assert_raises(ActiveRecord::RecordInvalid) { post.save! }
      end
    end

    context 'when provided' do
      it 'should update the post title' do
        post.title = 'Post B'
        assert post.save
      end
    end
  end
end
