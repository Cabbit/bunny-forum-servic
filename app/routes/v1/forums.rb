# frozen_string_literal: true
module Routes
  module V1
    class Forums < Grape::API
      resource :forums do
        desc ''
        get do
          stream serialize_as_stream(forums, {})
        end

        desc ''
        params do
          requires :forum, type: Hash do
            requires :description, type: String, desc: 'Description'
            optional :forum_id, type: Integer, desc: 'Parent forum id'
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
              optional :description, type: String, desc: 'Description'
            end
          end
          patch do
            forum.update!(permitted_params[:forum])

            status 202
            serialize(forum, is_collection: false)
          end

          desc ''
          get :forums do
            @forums = Forum.where(forum_id: params[:id]).find_each

            stream serialize_as_stream(forums, {})
          end
        end
      end
    end
  end
end
