# frozen_string_literal: true

require 'faraday'

class AppTree
  def corrospondence_conn
    @corrospondence_conn ||= Faraday.new(url: AppConstants.corrospondence_base_url) do |conn|
      conn.request :json
      conn.response :json
      conn.adapter :net_http
    end
  end

  def corrospondence_client
    @corrospondence_client ||= Corrospondence::Client.new(corrospondence_conn)
  end

  def conversation_service
    @conversation_service ||= ConversationService.new(corrospondence_client)
  end
end
