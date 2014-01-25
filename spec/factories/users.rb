# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "mail_#{n}@mail.com" }
    password "F_PASSWORD"
    password_confirmation "F_PASSWORD"
  end
end
