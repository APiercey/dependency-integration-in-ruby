# frozen_string_literal: true

require 'securerandom'

FactoryBot.define do
  factory :conversation_data, class: Corrospondence::ConversationData do
    id { SecureRandom.uuid }
    topic { 'Hello World' }
    summary { 'Lorem Ipsum' }
    created_at { '2020-12-12' }
    updated_at { '2020-12-12' }

    initialize_with { new(attributes) }
  end
end
