class Conversation < ApplicationRecord
  belongs_to :forum
  validates :topic, :summary, :content_owner_id, presence: true

  validates_length_of :topic, minimum: 5, maximum: 70, allow_blank: false
  validates_length_of :summary, minimum: 5, maximum: 250, allow_blank: false
end
