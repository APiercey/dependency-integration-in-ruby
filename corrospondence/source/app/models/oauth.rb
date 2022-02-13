class Oauth < ApplicationRecord
  validates :client_id, :client_secret, presence: true
end
