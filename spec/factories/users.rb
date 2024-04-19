# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { 'MyString' }
    surname { 'MyString' }
    age { 1 }
  end
end
