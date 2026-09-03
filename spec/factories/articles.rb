FactoryBot.define do
  factory :article do
    sequence(:title) { |n| "Article #{n}" }
    sequence(:url) { |n| "https://example.com/articles/#{n}" }
    notes { "Reading this later." }
    user
  end
end
