# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :task do
    due_date Date.tomorrow
    name "F_TASK"

    user
  end
end
