# frozen_string_literal: true

FactoryBot.define do
  factory :stock do
    name        { Faker::Finance.unique.ticker }
    corporation { Faker::Company.name }
    amount      { rand(1..10) }
    price       { rand(1..10) }

    association :bearer, factory: :bearer, strategy: :build
  end
end
