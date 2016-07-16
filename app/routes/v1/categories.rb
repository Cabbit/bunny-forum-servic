# frozen_string_literal: true
module Routes
  module V1
    class Categories < Grape::API
      helpers do
        def category
          @category ||= Category.find(params[:id])
        end

        def categories
          @categories ||= Category.find_each
        end
      end

      resource :categories do
        desc ''
        get do
          stream serialize_as_stream(categories, {})
        end

        desc ''
        params do
          requires :category, type: Hash do
            requires :title, type: String, desc: 'Title'
          end
        end
        post do
          @category = Category.create!(permitted_params[:category])

          status 201
          serialize(category, is_collection: false)
        end

        route_param :id do
          desc ''
          get do
            cache_control :public, max_age: 15

            serialize(category, is_collection: false)
          end

          desc ''
          params do
            requires :category, type: Hash do
              optional :title, type: String, desc: 'Title'
            end
          end
          patch do
            category.update!(permitted_params[:category])

            status 202
            serialize(category, is_collection: false)
          end
        end
      end
    end
  end
end
