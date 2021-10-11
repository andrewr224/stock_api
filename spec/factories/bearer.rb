# frozen_string_literal: true

FactoryBot.define do
  factory :bearer do
    sequence(:name) { |n| n.to_s + Faker::Name.name }
  end
end
