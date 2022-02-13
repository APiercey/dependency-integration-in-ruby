# frozen_string_literal: true

require 'active_model'
require 'pry'

module Corrospondence
  class AbstractData
    include ActiveModel::Validations

    def initialize(attrs)
      attrs
        .filter { |key, _value| respond_to?("#{key}=") }
        .each { |key, value| send("#{key}=", value) }

      validate!
    end
  end
end
