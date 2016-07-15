# frozen_string_literal: true
module Routes
  module V1
    class Posts < Grape::API
      helpers do
        def post
          @post ||= Post.find(params[:id])
        end
      end

      resource :posts do
        desc ''
        get do
          posts = Post.find_each
          stream serialize_as_stream(posts, {})
        end

        desc ''
        params do
          requires :post, type: Hash do
            optional :title, type: String, desc: 'Title'
          end
        end
        post do
          @post = Post.create!(permitted_params[:post])

          status 201
          serialize(post, is_collection: false)
        end

        route_param :id do
          desc ''
          get do
            serialize(post, is_collection: false)
          end

          desc ''
          params do
            requires :post, type: Hash do
              requires :title, type: String, desc: 'Title'
            end
          end
          patch do
            post.update!(permitted_params[:post])

            status 202
            serialize(post, is_collection: false)
          end
        end
      end
    end
  end
end
