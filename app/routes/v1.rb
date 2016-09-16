# frozen_string_literal: true
require 'grape/json_api/streamer'

module Routes
  module V1
    class API < Grape::API
      version 'v1', using: :accept_version_header, vendor: 'cabbit'
      content_type :json, 'application/json;charset=UTF-8'
      format :json
      prefix 'api/forum'

      helpers ApplicationHelper
      helpers ForumHelper
      helpers ParamsHelper

      rescue_from ActiveRecord::RecordNotFound do |e|
        error!(serialize_errors([{ detail: e.message }]), 404, 'Content-Type' => 'text/error')
      end

      rescue_from ActiveRecord::RecordInvalid do |e|
        error!(serialize_errors(e.record.errors), 422, 'Content-Type' => 'text/error')
      end

      rescue_from Grape::Exceptions::ValidationErrors do |e|
        error!(serialize_errors(e), 400, 'Content-Type' => 'text/error')
      end

      before do
        header['Access-Control-Allow-Origin'] = '*'
        header['Access-Control-Allow-Methods'] = 'GET, POST, PUT, PATCH, DELETE, OPTIONS, HEAD'
        I18n.locale = normalized_locale || default_locale
      end

      mount Routes::V1::Forums
      mount Routes::V1::Topics
      mount Routes::V1::Posts
    end
  end
end
