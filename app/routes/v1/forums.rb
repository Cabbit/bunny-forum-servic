# frozen_string_literal: true
module Routes
  module V1
    class Forums < Grape::API
      version 'v1', using: :accept_version_header, vendor: 'cabbit'
      format :json
      content_type :json, 'application/json;charset=UTF-8'

      rescue_from ActiveRecord::RecordNotFound do
        error!(serialize_errors([{detail: 'Forum not found.'}]), 404, 'Content-Type' => 'text/error')
      end

      helpers do
      end

      resource :forums do
        desc ''
        params do
          optional :limit, type: Integer, desc: 'Limit result'
          optional :offset, type: Integer, desc: 'Limit result', default: 0
          optional :forum_type, type: String, desc: 'Category, Forum, Sub forum', values: ['category', 'forum', 'sub-forum'], default: ['category', 'forum', 'sub-forum']
        end
        get do
          options = {}
          if params[:limit]
            meta  = { limit: params[:limit], offset: params[:offset], total: Forum.count }
            links = {
              self:  "/api/forums?limit=#{params[:limit]}&offset=#{params[:offset]}",
              first: "/api/forums?limit=#{params[:limit]}&offset=0",
              prev:  "/api/forums?limit=#{params[:limit]}&offset=#{params[:offset] - params[:limit]}",
              next:  "/api/forums?limit=#{params[:limit]}&offset=#{params[:offset] + params[:limit]}",
              last:  "/api/forums?limit=#{params[:limit]}&offset=#{Forum.count - params[:limit]}",
            }
            options = { meta: meta, links: links }
            forums = Forum.where(forum_type: params[:forum_type]).limit(params[:limit]).offset(params[:offset])
          else
            forums = Forum.where(forum_type: params[:forum_type]).find_each
          end
          stream serialize_as_stream(forums, options)
        end

        desc ''
        params do
          requires :forum, type: Hash do
            requires :title, type: String, desc: 'Title'
            requires :description, type: String, desc: 'Description'
            optional :forum_id, type: Integer, desc: 'Parent id'
            requires :forum_type, type: String, desc: 'Category, Forum, Sub forum', values: ['category', 'forum', 'sub-forum']
          end
        end
        post do
          forum = Forum.create(permitted_params[:forum])

          if forum.save
            status 201
            serialize(forum, is_collection: false)
          else
            serialize_errors(forum.errors)
          end
        end

        route_param :id do
          desc ''
          get do
            cache_control :public, max_age: 15

            forum = Forum.find(params[:id])
            serialize(forum, is_collection: false)
          end

          desc ''
          params do
            requires :forum, type: Hash do
              requires :title, type: String, desc: 'Title'
              requires :description, type: String, desc: 'Description'
              requires :forum_type, type: String, desc: 'Category, Forum, Sub forum', values: ['category', 'forum', 'sub-forum']
            end
          end
          patch do
            forum = Forum.find(params[:id])

            if forum.update(permitted_params[:forum])
              status 202
              serialize(forum, is_collection: false)
            else
              serialize_errors(forum.errors)
            end
          end

          route_param :forums do
            desc 'Sub forums'
            get do
              cache_control :public, max_age: 15

              forums = Forum.where(forum_id: params[:id])
              serialize(forums, is_collection: true)
            end
          end
        end
      end
    end
  end
end
