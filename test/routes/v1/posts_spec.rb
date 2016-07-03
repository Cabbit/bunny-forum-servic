# frozen_string_literal: true
require_relative '../../test_helper'

class ApiV1PostsTest < ApiV1TestCase
  let(:post_one) { Post.new }

  describe 'GET /posts' do
    before do
      Post.expects(:all).returns([post_one])
    end

    it 'should return 1 post' do
      get '/api/posts'

      assert_equal 1, json_response[:data].size
      assert_equal 200, status_code
    end
  end

  describe 'POST /posts' do
    before do
      Post.expects(:create).with('title' => 'B').returns(post_one)
    end

    it 'should create post 1' do
      post '/api/posts', post: { title: 'B' }

      assert_equal 1, json_response.size
      assert_equal 201, status_code
    end
  end

  describe 'GET /posts/:id' do
    context 'when post exists' do
      before do
        Post.expects(:find).with('1').returns(post_one)
      end

      it 'should return 1 post' do
        get '/api/posts/1'

        assert_equal 1, json_response.size
        assert_equal 200, status_code
      end
    end

    context 'when post no found' do
      before do
        Post.expects(:find).with('1').raises(ActiveRecord::RecordNotFound)
      end

      it 'should return error message 404 post not found' do
        get '/api/posts/1'

        assert_equal 'Post not found.', json_response[:error]
        assert_equal 404, status_code
      end
    end
  end

  describe 'PUT /posts/:id' do
    before do
      Post.expects(:find).with('1').returns(post_one)
      post_one.expects(:update).with('title' => 'B')
      post_one.expects(:save)
    end

    it 'should update post 1' do
      patch '/api/posts/1', post: { title: 'B' }

      assert_equal 1, json_response.size
      assert_equal 202, status_code
    end
  end
end
