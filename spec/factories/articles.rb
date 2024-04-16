FactoryBot.define do
  factory :article do
    title { "MyString" }
    body { "MyText" }
    user
  end
end
