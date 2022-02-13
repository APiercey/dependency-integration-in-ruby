# frozen_string_literal: true

require 'active_model'

module Corrospondence
  class ConversationData < Corrospondence::AbstractData
    attr_accessor :id, :topic, :summary, :created_at, :updated_at

    validates :id, :topic, :summary, :created_at, :updated_at, presence: true

    validates :id, length: { is: 36 }
    validates :topic, length: { minimum: 5, maximum: 50 }
    validates :summary, length: { minimum: 5, maximum: 150 }

    validates_format_of :created_at, :updated_at, with: /\d{4}-\d{2}-\d{2}/
  end
end
