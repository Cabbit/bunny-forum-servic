# frozen_string_literal: true
require_relative '../../spec_helper'

module Routes
  module V1
    class PostsSpec < ApiV1TestCase
      describe 'GET /posts' do
        it 'should return 1 post' do
          get '/api/posts'

          assert_equal 1, json_response[:data].size
          assert_equal 200, status_code
        end
      end

      describe 'POST /posts' do
        context 'when attributes valid' do
          it 'should create post 1' do
            post '/api/posts', post: { title: 'B' }

            assert_equal 1, json_response.size
            assert_equal 201, status_code
          end
        end

        context 'when attributes invalid' do
          let(:error_message) do
            {
              errors: [
                {
                  source: { pointer: '/data/attributes/title' },
                  detail: 'Title can\'t be blank'
                }
              ]
            }
          end

          it 'should create post 1' do
            post '/api/posts', post: { title: '' }

            assert_equal error_message, json_response
            assert_equal 422, status_code
          end
        end
      end

      describe 'GET /posts/:id' do
        context 'when post exists' do
          it 'should return 1 post' do
            get '/api/posts/1'

            assert_equal 1, json_response.size
            assert_equal 200, status_code
          end
        end

        context 'when post no found' do
          it 'should return error message 404 post not found' do
            get '/api/posts/1000'

            assert_equal 'Couldn\'t find Post with \'id\'=1000', json_response[:errors].first[:detail]
            assert_equal 404, status_code
          end
        end
      end

      describe 'PUT /posts/:id' do
        context 'when attributes valid' do
          it 'should update post 1' do
            patch '/api/posts/1', post: { title: 'B' }

            assert_equal 1, json_response.size
            assert_equal 202, status_code
          end
        end
      end
    end
  end
end
