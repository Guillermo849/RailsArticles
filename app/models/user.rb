class User < ApplicationRecord
  validates :first_name, :surname, :age, presence: true
  validatess :age, numericality: { only_integer: true }, inclusion: { in: 1..120 }
end