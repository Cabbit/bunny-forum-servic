# frozen_string_literal: true
module ApiTestHelpers
  def json_response
    JSON.parse(last_response.body, symbolize_names: true)
  end

  def status_code
    last_response.status
  end
end
