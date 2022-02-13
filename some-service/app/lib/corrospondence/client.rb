# frozen_string_literal: true

module Corrospondence
  class Client
    def initialize(conn)
      @conn = conn
    end

    def create_forum(attrs)
      handle_response(@conn.post('/forums', attrs.to_json)) do |body|
        Corrospondence::ForumData.new(body)
      end
    end

    def create_conversation(forum_id, attrs)
      handle_response(@conn.post("/forums/#{forum_id}/conversations", attrs.to_json)) do |body|
        Corrospondence::ConversationData.new(body)
      end
    end

    def fetch_forum(id)
      handle_response(@conn.get("/forums/#{id}")) do |body|
        Corrospondence::ForumData.new(body)
      end
    end

    def fetch_conversation(forum_id, id)
      handle_response(@conn.get("/forums/#{forum_id}/conversations/#{id}")) do |body|
        Corrospondence::ConversationData.new(body)
      end
    end

    private

    def build_error(data)
      Corrospondence::ErrorData.new("response_errors" => data)
    end

    def handle_response(response, &block)
      Corrospondence::Response.new.tap do |obj|
        obj.status = response.status
        obj.data = build_data!(response, &block)
      end
    end

    def build_data!(response)
      case response.status
      when 200..201
        yield(response.body)
      when 404
        build_error({ response.body[:error] => response.body[:exception] })
      when 422
        build_error(response.body)
      else
        raise "Unexpected result. Server died with #{response.status} and body #{response.body}"
      end
    end
  end
end
