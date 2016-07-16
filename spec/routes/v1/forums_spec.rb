# frozen_string_literal: true
require_relative '../../spec_helper'

module Routes
  module V1
    class ForumsSpec < ApiV1TestCase
      describe 'GET /forums' do
        it 'should return 1 forum' do
          get '/api/forums'

          assert_equal 2, json_response[:data].size
          assert_equal 200, status_code
        end
      end

      describe 'POST /forums' do
        context 'when attributes valid' do
          it 'should create forum 1' do
            post '/api/forums', forum: { title: 'A', description: 'A' }

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
                }, {
                  source: { pointer: '/data/attributes/description' },
                  detail: 'Description can\'t be blank'
                }
              ]
            }
          end

          it 'should create forum 1' do
            post '/api/forums', forum: { title: '', description: '' }

            assert_equal error_message, json_response
            assert_equal 422, status_code
          end
        end
      end

      describe 'GET /forums/:id' do
        context 'when forum exists' do
          it 'should return 1 forum' do
            get '/api/forums/1'

            assert_equal 1, json_response.size
            assert_equal 200, status_code
          end
        end

        context 'when forum no found' do
          it 'should return error message 404 forum not found' do
            get '/api/forums/1000'

            assert_equal 'Couldn\'t find Forum with \'id\'=1000', json_response[:errors].first[:detail]
            assert_equal 404, status_code
          end
        end
      end

      describe 'PUT /forums/:id' do
        context 'when attributes valid' do
          it 'should update forum 1' do
            patch '/api/forums/1', forum: { title: 'A' }

            assert_equal 1, json_response.size
            assert_equal 202, status_code
          end
        end
      end

      describe 'GET /forums/:id/forums' do
        context 'when attributes valid' do
          it 'should get the sub forums' do
            get '/api/forums/1/forums'

            assert_equal 1, json_response.size
            assert_equal 200, status_code
          end
        end
      end
    end
  end
end
