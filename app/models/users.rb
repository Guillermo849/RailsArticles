class Users < ApplicationRecord
  validates :first_name, presence: true
  validates :surname, presence: true
  validates :age, presence: true, integer: true
end
