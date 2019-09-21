class User < ApplicationRecord
  has_secure_password

  has_many :recipes

  validates :name, :password_digest, presence: true
  validates :email, presence: true, uniqueness: true
end