class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :articles, dependent: :delete_all
  validates :first_name, :surname, :age, presence: true
  validates :age, numericality: { only_integer: true }, inclusion: { in: 1..120 }
end
