# frozen_string_literal: true
module Routes
  module V1
    class Forums < Grape::API
      helpers do
        def forum
          @forum ||= Forum.find(params[:id])
        end
      end

      resource :forums do
        desc ''
        get do
          forums = Forum.find_each
          stream serialize_as_stream(forums, {})
        end

        desc ''
        params do
          requires :forum, type: Hash do
            requires :title, type: String, desc: 'Title'
            requires :description, type: String, desc: 'Description'
            optional :forum_id, type: Integer, desc: 'Parent id'
          end
        end
        post do
          @forum = Forum.create!(permitted_params[:forum])

          status 201
          serialize(forum, is_collection: false)
        end

        route_param :id do
          desc ''
          get do
            cache_control :public, max_age: 15

            serialize(forum, is_collection: false)
          end

          desc ''
          params do
            requires :forum, type: Hash do
              optional :title, type: String, desc: 'Title'
              optional :description, type: String, desc: 'Description'
            end
          end
          patch do
            forum.update!(permitted_params[:forum])

            status 202
            serialize(forum, is_collection: false)
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
