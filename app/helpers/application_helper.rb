# frozen_string_literal: true
module ApplicationHelper
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
