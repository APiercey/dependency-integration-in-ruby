# frozen_string_literal: true

require 'securerandom'

module CorrospondenceOauthHelper
  def self.create_access_token!
    response_body = parse_response do
      client_data = create_oauth_client!

      Faraday.post(
        "#{AppConstants.corrospondence_base_url}/oauths/token",
        { client_id: client_data['client_id'], client_secret: client_data['client_secret'] }.to_json,
        { 'Content-Type' => 'application/json' }
      )
    end

    response_body['access_token']
  end

  def self.create_oauth_client!
    parse_response do
      Faraday.post(
        "#{AppConstants.corrospondence_base_url}/oauths",
        { client_id: SecureRandom.hex(10), client_secret: SecureRandom.hex(12) }.to_json,
        { 'Content-Type' => 'application/json' }
      )
    end
  end

  def self.parse_response
    JSON.parse(yield.body)
  end
end
