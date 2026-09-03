class Article < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :url, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) }

  scope :recent, -> { order(created_at: :desc) }
end
