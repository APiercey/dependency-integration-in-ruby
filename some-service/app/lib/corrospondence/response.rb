# frozen_string_literal: true

module Corrospondence
  class Response
    include ActiveModel::Validations

    attr_accessor :data, :status

    def intitialize
      validate!
    end

    validates :data, :status, presence: true
    validates :status, inclusion: { in: [200, 201, 404, 422] }
    validate :response_data?

    private

    def response_data?
      errors.add(:data, 'is not a valid response data class') unless data.is_a?(Corrospondence::AbstractData)
    end
  end
end
