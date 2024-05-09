# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    surname { 'MyString' }
    age { 1 }
    email { Faker::Internet.email }
    password { Faker::Password.password(min_length: 8) }
  end
end
