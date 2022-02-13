# frozen_string_literal: true

require 'securerandom'

FactoryBot.define do
  factory :forum_data, class: Corrospondence::ForumData do
    id { SecureRandom.uuid }
    title { 'Hello World' }
    description { 'Lorem Ipsum' }
    created_at { '2020-12-12' }
    updated_at { '2020-12-12' }

    initialize_with { new(attributes) }
  end
end
