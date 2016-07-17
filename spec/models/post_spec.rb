# frozen_string_literal: true
require_relative '../spec_helper'

class PostSpec < TestCase
  let(:subject) { Post.find(1) }
  let(:topic)   { Topic.find(1) }
  let(:forum)   { Forum.find(1) }

  describe '#after_create' do
    it 'should update the topic replies counter by 1' do
      Post.create!(title: 'A', topic_id: 1)

      assert_equal 2, topic.replies_count
    end

    it 'should update the forums\'s post counter by 1' do
      Post.create!(title: 'A', topic_id: 1)

      assert_equal 2, forum.posts_count
    end
  end

  describe '#increment_topic_replies_count!' do
    it 'should update the topic replies counter by 1' do
      subject.increment_topic_replies_count!

      assert_equal 2, topic.replies_count
    end

    it 'should update the forums\'s post counter by 1' do
      subject.increment_topic_replies_count!

      assert_equal 2, forum.posts_count
    end
  end
end
