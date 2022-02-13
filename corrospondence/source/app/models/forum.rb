class Forum < ApplicationRecord
  has_many :conversations, dependent: :destroy
  validates :title, :description, :category, presence: true

  validates_length_of :title, minimum: 5, maximum: 70, allow_blank: false
  validates_length_of :description, minimum: 5, maximum: 150, allow_blank: false

  validates :category, inclusion: { in: %w[finance art technology crypto books movies television sports education love family travel] }
end
