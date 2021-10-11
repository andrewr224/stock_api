# frozen_string_literal: true

FactoryBot.define do
  factory :stock do
    sequence(:name) { |n| n.to_s + Faker::Finance.ticker }
    corporation     { Faker::Company.name }
    amount          { rand(1..10) }
    price           { rand(1..10) }

    association :bearer, factory: :bearer, strategy: :build

    trait :discarded do
      discarded_at { Time.zone.now }
    end
  end
end
