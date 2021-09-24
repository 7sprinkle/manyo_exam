FactoryBot.define do
  factory :label do
    sequence(:name) { |n| "Label#{n + 1}"}
  end
end
