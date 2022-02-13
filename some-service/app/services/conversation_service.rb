# frozen_string_literal: true

class ConversationService
  class StartFailed < StandardError
    def initialize(errors)
      super(errors.map { |key, value| "#{key}: #{value}" })
    end
  end

  def initialize(corrospondence_client)
    @corrospondence_client = corrospondence_client
  end

  def start_conversation!(parameters)
    result = @corrospondence_client.create_conversation(AppConstants.pre_registered_forum_id, parameters)

    fail StartFailed, result.data.response_errors unless result.status == 201

    build_conversation(result.data)
  end

  def find_conversation(id)
    result = @corrospondence_client.fetch_conversation(AppConstants.pre_registered_forum_id, id)

    return nil unless result.status == 200

    build_conversation(result.data)
  end

  def exists?(id)
    find_conversation(id) != nil
  end

  private

  def build_conversation(data)
    Conversation.new(id: data.id, topic: data.topic, summary: data.summary)
  end
end
