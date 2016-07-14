# frozen_string_literal: true
module Routes
  module V1
    class Topics < Grape::API
      version 'v1', using: :accept_version_header, vendor: 'cabbit'
      format :json
      content_type :json, 'application/json;charset=UTF-8'

      rescue_from ActiveRecord::RecordNotFound do
        error!(serialize_errors([{detail: 'Forum not found.'}]), 404, 'Content-Type' => 'text/error')
      end

      helpers do
      end

      resource :topics do
        desc ''
        params do
          optional :forum_id, type: Integer, desc: 'Topics for a given forum_id'
        end
        get do
          topics = Topic.where(permitted_params).find_each
          stream serialize_as_stream(topics, {})
        end

        desc ''
        params do
          requires :topic, type: Hash do
            requires :title, type: String, desc: 'Title'
            requires :forum_id, type: Integer, desc: 'Forum Id'
          end
        end
        post do
          topic = Topic.create(permitted_params[:topic])

          if topic.save
            status 201
            serialize(topic, is_collection: false)
          else
            serialize_errors(topic.errors)
          end
        end

        route_param :id do
          desc ''
          get do
            topic = Topic.find(params[:id])
            serialize(topic, is_collection: false)
          end

          desc ''
          get :forum do
            topic = Topic.find(params[:id])
            forum = Forum.find(topic.forum_id)
            serialize(forum, is_collection: false)
          end
        end
      end
    end
  end
end
