# frozen_string_literal: true

FactoryBot.define do
  factory :corrospondence_response, class: Corrospondence::Response do
    data { nil }
    status { 0 }

    trait :created_forum do
      status { 201 }
      data { build(:forum_data) }
    end

    trait :created_conversation do
      status { 201 }
      data { build(:conversation_data) }
    end

    trait :found_forum do
      status { 200 }
      data { build(:forum_data) }
    end

    trait :found_conversation do
      status { 200 }
      data { build(:conversation_data) }
    end

    trait :change_failed do
      status { 422 }
      data { build(:error_data) }
    end

    trait :not_found do
      status { 404 }
      data { build(:error_data) }
    end
  end
end
