# frozen_string_literal: true

require 'securerandom'

FactoryBot.define do
  factory :error_data, class: Corrospondence::ErrorData do
    response_errors do
      { 'default' => 'error' }
    end

    initialize_with { new(attributes) }
  end
end
