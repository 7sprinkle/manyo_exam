FactoryBot.define do
  factory :task do
    title {'test_title'}
    content {'test_content'}
    expired_at {'2021-10-12 00:00:00'}
    status {'未着手'}
    priority {'低'}
    association :user, user: :basic_user
    after(:create) do |task|
      create_list(:labeling, 1, task: task, label: create(:label))
    end
  end
  factory :second_task, class: Task do
    title {'test2_title'}
    content {'test2_content'}
    expired_at {'2021-10-30 00:00:00'}
    status {'着手中'}
    priority {'低'}
    association :user, user: :basic_user
    after(:create) do |second_task|
      create_list(:labeling, 2, task: second_task, label: create(:label))
    end
  end
end