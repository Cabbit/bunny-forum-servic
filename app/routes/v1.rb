# frozen_string_literal: true
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

      mount Routes::V1::Posts
    end
  end
end
