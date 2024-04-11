class User < ApplicationRecord
  has_many :articles, dependent: :delete_all
  validates :first_name, :surname, :age, presence: true
  validates :age, numericality: { only_integer: true }, inclusion: { in: 1..120 }
end
