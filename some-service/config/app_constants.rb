# frozen_string_literal: true

module AppConstants
  def self.corrospondence_base_url
    ENV['CORROSPONDENCE_BASE_URL']
  end

  def self.pre_registered_forum_id
    ENV['PRE_REGISTERED_FORUM_ID']
  end
end
