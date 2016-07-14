# frozen_string_literal: true
require 'grape/json_api/streamer'

module Routes
  module V1
    class API < Grape::API
      version 'v1'
      format :json
      default_format :json
      prefix 'api'
      helpers ParamsHelper

      helpers do
        def serialize(model, options = {})
          JSONAPI::Serializer.serialize(model, options)
        end

        def serialize_as_stream(collection, options)
          Grape::JSONAPI::Streamer.new(collection, options)
        end

        def serialize_errors(errors)
          JSONAPI::Serializer.serialize_errors(errors)
        end

        def normalized_locale
          locale ? locale.downcase.to_sym : default_locale
        end

        def default_locale
          :en
        end

        def locale
          @locale ||= headers['Accept-Language'].to_s.split('-').first
        end
      end

      before do
        header['Access-Control-Allow-Origin'] = '*'
        header['Access-Control-Request-Method'] = '*'
        I18n.locale = normalized_locale || default_locale
      end

      mount Routes::V1::Forums
      mount Routes::V1::Topics
      mount Routes::V1::Posts
    end
  end
end
