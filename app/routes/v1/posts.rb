# frozen_string_literal: true
module Routes
  module V1
    class Posts < Grape::API
      version 'v1', using: :accept_version_header, vendor: 'cabbit'
      format :json
      content_type :json, 'application/json;charset=UTF-8'

      rescue_from ActiveRecord::RecordNotFound do
        error!({ error: 'Post not found.' }, 404, 'Content-Type' => 'text/error')
      end

      helpers do
      end

      resource :posts do
        desc ''
        get do
          posts = Post.find_each
          stream serialize_as_stream(posts)
        end

        desc ''
        params do
          requires :post, type: Hash do
            requires :title, type: String, desc: 'Title'
          end
        end
        post do
          post = Post.create(permitted_params[:post])

          status 201
          serialize(post, is_collection: false)
        end

        route_param :id do
          desc ''
          get do
            cache_control :public, max_age: 15

            post = Post.find(params[:id])
            serialize(post, is_collection: false)
          end

          desc ''
          params do
            requires :post, type: Hash do
              requires :title, type: String, desc: 'Title'
            end
          end
          patch do
            post = Post.find(params[:id])
            post.update(permitted_params[:post])
            post.save

            status 202
            serialize(post, is_collection: false)
          end
        end
      end
    end
  end
end
