# frozen_string_literal: true

require 'active_model'

module Corrospondence
  class ForumData < Corrospondence::AbstractData
    attr_accessor :id, :title, :description, :created_at, :updated_at

    validates :id, :title, :description, :created_at, :updated_at, presence: true

    validates :id, length: { is: 36 }
    validates :title, length: { minimum: 5, maximum: 50 }
    validates :description, length: { minimum: 5, maximum: 150 }

    validates_format_of :created_at, :updated_at, with: /\d{4}-\d{2}-\d{2}/
  end
end
