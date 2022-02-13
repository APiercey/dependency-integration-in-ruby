# frozen_string_literal: true

class Conversation
  attr_reader :id, :topic, :summary

  def initialize(id:, topic:, summary:)
    @id = id
    @topic = topic
    @summary = summary
  end
end
