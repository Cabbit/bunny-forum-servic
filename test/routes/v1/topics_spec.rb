# frozen_string_literal: true
require_relative '../../test_helper'

module Routes
  module V1
    class TopicsSpec < ApiV1TestCase
      describe 'GET /topics' do
        it 'should return 1 topic' do
          get '/api/topics'

          assert_equal 1, json_response[:data].size
          assert_equal 200, status_code
        end
      end

      describe 'POST /topics' do
        context 'when attributes valid' do
          it 'should create topic 1' do
            post '/api/topics', topic: { title: 'A', forum_id: 1 }

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

          it 'should create topic 1' do
            post '/api/topics', topic: { title: '', forum_id: 1 }

            assert_equal error_message, json_response
            assert_equal 422, status_code
          end
        end
      end

      describe 'GET /topics/:id' do
        context 'when topic exists' do
          it 'should return 1 topic' do
            get '/api/topics/1'

            assert_equal 1, json_response.size
            assert_equal 200, status_code
          end
        end

        context 'when topic no found' do
          it 'should return error message 404 topic not found' do
            get '/api/topics/1000'

            assert_equal 'Couldn\'t find Topic with \'id\'=1000', json_response[:errors].first[:detail]
            assert_equal 404, status_code
          end
        end
      end

      describe 'PUT /topics/:id' do
        context 'when attributes valid' do
          it 'should update topic 1' do
            patch '/api/topics/1', topic: { title: 'B' }

            assert_equal 1, json_response.size
            assert_equal 202, status_code
          end
        end
      end

      describe 'GET /topics/:id/forums' do
        it 'should get the forums for the topic' do
          get '/api/topics/1/forums'

          assert_equal 1, json_response.size
          assert_equal 200, status_code
        end
      end
    end
  end
end
