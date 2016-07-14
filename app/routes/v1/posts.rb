# frozen_string_literal: true
module Routes
  module V1
    class Posts < Grape::API
      version 'v1', using: :accept_version_header, vendor: 'cabbit'
      format :json
      content_type :json, 'application/json;charset=UTF-8'

      rescue_from ActiveRecord::RecordNotFound do
        error!(serialize_errors([{detail: 'Post not found.'}]), 404, 'Content-Type' => 'text/error')
      end

      rescue_from ActiveRecord::RecordInvalid do |e|
        error!(serialize_errors(e.record.errors), 422, 'Content-Type' => 'text/error')
      end

      helpers do
        def post
          @post ||= Post.find(params[:id])
        end
      end

      resource :posts do
        desc ''
        params do
          optional :limit, type: Integer, desc: 'Limit result'
          optional :offset, type: Integer, desc: 'Limit result', default: 0
        end
        get do
          options = {}
          if params[:limit]
            meta  = { limit: params[:limit], offset: params[:offset], total: Post.count }
            links = {
              self:  "/api/posts?limit=#{params[:limit]}&offset=#{params[:offset]}",
              first: "/api/posts?limit=#{params[:limit]}&offset=0",
              prev:  "/api/posts?limit=#{params[:limit]}&offset=#{params[:offset] - params[:limit]}",
              next:  "/api/posts?limit=#{params[:limit]}&offset=#{params[:offset] + params[:limit]}",
              last:  "/api/posts?limit=#{params[:limit]}&offset=#{Post.count - params[:limit]}",
            }
            options = { meta: meta, links: links }
            posts = Post.limit(params[:limit]).offset(params[:offset])
          else
            posts = Post.find_each
          end
          stream serialize_as_stream(posts, options)
        end

        desc ''
        params do
          requires :post, type: Hash do
            requires :title, type: String, desc: 'Title'
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
