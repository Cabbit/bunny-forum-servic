# frozen_string_literal: true
require_relative '../spec_helper'

class TopicSpec < TestCase
  let(:subject) { Topic.find(1) }
  let(:forum)   { Forum.find(1) }

  describe '#increment_views_counter!' do
    it 'should update the views counter by 1' do
      subject.increment_views_counter!

      assert_equal 2, subject.views_count
    end
  end

  describe '#increment_replies_counter!' do
    it 'should update the replies counter by 1' do
      subject.increment_replies_counter!

      assert_equal 2, subject.replies_count
    end

    it 'should update the forum posts counter by 1' do
      subject.increment_replies_counter!

      assert_equal 2, forum.posts_count
    end
  end
end
