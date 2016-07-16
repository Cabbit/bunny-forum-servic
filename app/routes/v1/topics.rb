# frozen_string_literal: true
module Routes
  module V1
    class Topics < Grape::API
      resource :topics do
        helpers do
          def topic
            @topic ||= Topic.find(params[:id])
          end

          def topics
            @topics ||= Topic.where(permitted_params).find_each
          end

          def forum
            @forum ||= Forum.find(topic.forum_id)
          end
        end

        desc ''
        params do
          optional :forum_id, type: Integer, desc: 'Topics for a given forum_id'
        end
        get do
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
          @topic = Topic.create!(permitted_params[:topic])

          status 201
          serialize(topic, is_collection: false)
        end

        route_param :id do
          desc ''
          get do
            serialize(topic, is_collection: false)
          end

          desc ''
          params do
            requires :topic, type: Hash do
              optional :title, type: String, desc: 'Title'
            end
          end
          patch do
            topic.update!(permitted_params[:topic])

            status 202
            serialize(topic, is_collection: false)
          end

          desc ''
          get :forums do
            serialize(forum, is_collection: false)
          end
        end
      end
    end
  end
end
