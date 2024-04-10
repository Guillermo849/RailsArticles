class Article < ApplicationRecord
  belongs_to :user
  validates :title, :body, :user_id, presence: true
  validates :user_id, numericality: { only_integer: true }
end
