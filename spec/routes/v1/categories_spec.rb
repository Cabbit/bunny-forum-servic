# frozen_string_literal: true
require_relative '../../spec_helper'

module Routes
  module V1
    class CategoriesSpec < ApiV1TestCase
      describe 'GET /categories' do
        it 'should return 1 category' do
          get '/api/categories'

          assert_equal 1, json_response[:data].size
          assert_equal 200, status_code
        end
      end

      describe 'POST /categories' do
        context 'when attributes valid' do
          it 'should create Category 1' do
            post '/api/categories', category: { title: 'A' }

            assert_equal 1, json_response.size
            assert_equal 201, status_code
          end
        end

        context 'when params invalid' do
          let(:error_message) do
            {
              errors: [
                {
                  params: ['category'], messages: ['is missing']
                }, {
                  params: ['category[title]'], messages: ['is missing']
                }
              ]
            }
          end

          it 'should return params missing error' do
            post '/api/categories'

            assert_equal error_message, json_response
            assert_equal 400, status_code
          end
        end

        context 'when model invalid' do
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

          it 'should create category 1' do
            post '/api/categories', category: { title: '' }

            assert_equal error_message, json_response
            assert_equal 422, status_code
          end
        end
      end

      describe 'GET /categories/:id' do
        context 'when category exists' do
          it 'should return 1 category' do
            get '/api/categories/1'

            assert_equal 1, json_response.size
            assert_equal 200, status_code
          end
        end

        context 'when category no found' do
          it 'should return error message 404 category not found' do
            get '/api/categories/1000'

            assert_equal 'Couldn\'t find Category with \'id\'=1000', json_response[:errors].first[:detail]
            assert_equal 404, status_code
          end
        end
      end

      describe 'PUT /categories/:id' do
        context 'when attributes valid' do
          it 'should update category 1' do
            patch '/api/categories/1', category: { title: 'A' }

            assert_equal 1, json_response.size
            assert_equal 202, status_code
          end
        end
      end
    end
  end
end
