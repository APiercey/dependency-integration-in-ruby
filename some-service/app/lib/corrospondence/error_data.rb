# frozen_string_literal: true

require 'active_model'

module Corrospondence
  class ErrorData < Corrospondence::AbstractData
    attr_accessor :response_errors

    validates :response_errors, presence: true

    def add_error(title, message)
      self.response_errors = response_errors.merge({ title => message })
    end
  end
end
